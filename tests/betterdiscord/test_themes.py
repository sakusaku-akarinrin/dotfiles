"""Offline checks for the two standalone BetterDiscord themes.

Install tests/betterdiscord/requirements.txt in a venv, then run pytest.
Browser checks use a deliberately representative fixture, not a live Discord client.
"""
import os
from pathlib import Path
import re
import shutil
import tempfile

import pytest
import tinycss2
from playwright.sync_api import expect, sync_playwright

ROOT = Path(__file__).resolve().parents[2]
FIXTURE = Path(__file__).with_name("preview.html")
THEMES = ("sakura-season", "violet-evergarden")
MODES = ("theme-dark", "theme-darker", "theme-midnight", "theme-light")


def theme_path(theme):
    return ROOT / theme / "BetterDiscord" / "themes" / f"{theme}.theme.css"


def parse_rules(text):
    rules = tinycss2.parse_stylesheet(text, skip_comments=True, skip_whitespace=True)
    for rule in rules:
        assert rule.type != "error", str(rule)
        if rule.type == "at-rule":
            assert rule.lower_at_keyword in ("media", "supports"), rule.lower_at_keyword
            if rule.content is not None:
                yield from parse_rules(tinycss2.serialize(rule.content))
        else:
            assert rule.type == "qualified-rule", rule.type
            declarations = tinycss2.parse_declaration_list(
                rule.content, skip_comments=True, skip_whitespace=True
            )
            for declaration in declarations:
                assert declaration.type == "declaration", str(declaration)
            yield rule


def contrast(foreground, background):
    def luminance(value):
        channels = [float(x) / 255 for x in re.findall(r"[\d.]+", value)[:3]]
        assert len(channels) == 3, value
        linear = [x / 12.92 if x <= 0.04045 else ((x + 0.055) / 1.055) ** 2.4 for x in channels]
        return sum(a * b for a, b in zip(linear, (0.2126, 0.7152, 0.0722)))
    a, b = sorted((luminance(foreground), luminance(background)))
    return (b + 0.05) / (a + 0.05)


@pytest.fixture(scope="session")
def browser():
    executable = os.environ.get("BETTERDISCORD_TEST_BROWSER") or shutil.which("chromium") or shutil.which("chromium-browser")
    with sync_playwright() as playwright:
        instance = playwright.chromium.launch(
            headless=True, executable_path=executable, timeout=90000,
            args=["--no-sandbox", "--disable-gpu", "--disable-dev-shm-usage"] if executable else [],
        )
        yield instance
        instance.close()


@pytest.fixture
def page(browser):
    page = browser.new_page(viewport={"width": 1440, "height": 1000})
    yield page
    page.close()


def load(page, theme, mode="theme-dark", **extra):
    assert theme_path(theme).is_file(), f"Missing theme: {theme_path(theme)}"
    errors = []
    page.on("pageerror", lambda error: errors.append(str(error)))
    page.goto(FIXTURE.as_uri() + f"?theme={theme}&mode={mode}")
    page.wait_for_function("document.documentElement.dataset.ready === 'true'")
    page.evaluate("document.documentElement.classList.add('visual-refresh')")
    if extra.get("high_contrast"):
        page.evaluate("document.documentElement.classList.add('high-contrast-mode')")
    assert not errors, errors


def style(page, selector, name):
    return page.locator(selector).evaluate(
        "(el, name) => getComputedStyle(el).getPropertyValue(name).trim()", name
    )


@pytest.mark.parametrize("theme", THEMES)
def test_standalone_metadata_and_syntax(theme):
    source = theme_path(theme).read_text()
    assert source.startswith("/**\n"), "Metadata must be the first bytes"
    header = source.split("*/", 1)[0]
    for field in ("name", "author", "description", "version"):
        assert re.search(rf"^ \* @{field} .+", header, re.M), field
    assert re.search(r"@version \d+\.\d+\.\d+", header)
    assert not re.search(r"@import|url\(|https?://", source.split("*/", 1)[1], re.I)
    rules = list(parse_rules(source))
    assert len(rules) >= 12
    assert "prefers-reduced-motion" in source
    assert "forced-colors: none" in source
    assert not re.search(r"\.[a-zA-Z]+_[a-f0-9]{6}\b", source), "No pinned class hashes"
    assert "--control-primary-text-default" in source
    assert "--interactive-text-default" in source
    assert "--message-mentioned-background-default" in source
    # Status/critical controls are intentionally kept native and recognizable.
    assert not re.search(r"--(?:status-|icon-status-|control-critical-)[\w-]*\s*:", source)


@pytest.mark.parametrize("theme", THEMES)
@pytest.mark.parametrize("mode", MODES)
def test_palette_and_readable_controls(page, theme, mode):
    load(page, theme, mode)
    assert style(page, "#chat", "background-color") != "rgb(49, 51, 56)"
    for selector in ("#body-text", "#muted-text", "#sidebar-label", "#menu-item"):
        surface = "#sidebar" if selector == "#sidebar-label" else "#menu" if selector == "#menu-item" else "#chat"
        assert contrast(style(page, selector, "color"), style(page, surface, "background-color")) >= 4.5, selector
    for selector in ("#brand-button", "#legacy-brand-button"):
        assert contrast(style(page, selector, "color"), style(page, selector, "background-color")) >= 4.5
        page.locator(selector).hover()
        page.wait_for_timeout(160)
        assert contrast(style(page, selector, "color"), style(page, selector, "background-color")) >= 4.5
    assert contrast(style(page, "#link", "color"), style(page, "#chat", "background-color")) >= 4.5
    assert style(page, "#danger-button", "background-color") == "rgb(180, 35, 55)"
    assert style(page, "#status-online", "background-color") == "rgb(35, 165, 90)"
    page.locator("#brand-button").focus()
    assert style(page, "#brand-button", "outline-style") == "solid"
    assert style(page, "#brand-button", "outline-width") == "2px"


@pytest.mark.parametrize("theme", THEMES)
def test_interactions_and_scoping(page, theme):
    load(page, theme)
    assert style(page, "#selected-channel", "box-shadow") != "none"
    assert style(page, "#chat-messages-fixture-1", "box-shadow") != "none"
    assert style(page, "#reaction", "border-top-color") != "rgb(0, 0, 0)"
    assert style(page, "#composer", "border-radius") == "12px"
    assert style(page, "#unrelated-container", "border-radius") == "0px"
    page.locator("#editor").focus()
    # CSS transitions have not necessarily finished when focus() returns.
    expect(page.locator("#composer")).to_have_css(
        "border-top-color", style(page, "#focus-probe", "color")
    )
    page.locator("#editor").fill("A keyboard-first theme")
    assert page.locator("#editor").inner_text() == "A keyboard-first theme"
    page.locator("#channel-other").click()
    assert page.locator("#channel-other").get_attribute("aria-current") == "page"
    page.emulate_media(reduced_motion="reduce")
    assert style(page, "#composer", "transition-duration") == "0s"


@pytest.mark.parametrize("theme", THEMES)
def test_forced_colors_and_native_high_contrast(page, theme):
    load(page, theme, high_contrast=True)
    assert style(page, "#chat", "background-color") == "rgb(49, 51, 56)"
    assert style(page, "#composer", "border-radius") == "0px"
    page.evaluate("document.documentElement.classList.remove('high-contrast-mode')")
    page.emulate_media(forced_colors="active")
    assert style(page, "#composer", "border-radius") == "0px"


def test_preview_switching(page):
    load(page, "sakura-season")
    page.locator("#theme-select").select_option("violet-evergarden")
    page.wait_for_function("document.documentElement.dataset.ready === 'true'")
    expect(page.locator("#chat")).to_have_css("background-color", "rgb(20, 18, 36)")
    assert "THEME=violet-evergarden" in page.locator(".markup_fixture pre code").inner_text()
    page.locator("#mode-select").select_option("theme-light")
    page.wait_for_function("document.documentElement.dataset.ready === 'true'")
    expect(page.locator("#chat")).to_have_css("background-color", "rgb(251, 250, 244)")
    page.locator("#theme-select").select_option("sakura-season")
    page.wait_for_function("document.documentElement.dataset.ready === 'true'")
    expect(page.locator("#chat")).to_have_css("background-color", "rgb(255, 248, 250)")
    assert "THEME=sakura-season" in page.locator(".markup_fixture pre code").inner_text()


@pytest.mark.parametrize("theme", THEMES)
def test_copy_deployment(theme):
    with tempfile.TemporaryDirectory() as temporary:
        destination = Path(temporary) / "config"
        shutil.copytree(ROOT / theme, destination)
        copied = destination / "BetterDiscord" / "themes" / f"{theme}.theme.css"
        assert copied.read_bytes() == theme_path(theme).read_bytes()


@pytest.mark.parametrize("theme", THEMES)
@pytest.mark.parametrize("width", (900, 1440))
def test_preview_layout(page, theme, width):
    load(page, theme)
    page.set_viewport_size({"width": width, "height": 1000})
    assert page.evaluate("document.documentElement.scrollWidth <= innerWidth")
    assert page.locator("#editor").is_visible()
    assert page.locator("#brand-button").is_visible()
    assert page.locator("#body-text").evaluate("el => el.scrollWidth <= el.clientWidth")
