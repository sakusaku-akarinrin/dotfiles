"""Render explicitly labeled BetterDiscord preview fixtures, not client screenshots."""
import argparse
import os
from pathlib import Path
import shutil

from playwright.sync_api import sync_playwright

from test_themes import FIXTURE, THEMES


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, required=True)
    parser.add_argument("--browser", default=os.environ.get("BETTERDISCORD_TEST_BROWSER"))
    args = parser.parse_args()
    args.output_dir.mkdir(parents=True, exist_ok=True)
    executable = args.browser or shutil.which("chromium") or shutil.which("chromium-browser")
    with sync_playwright() as playwright:
        browser = playwright.chromium.launch(
            headless=True, executable_path=executable, timeout=90000,
            args=["--no-sandbox", "--disable-gpu", "--disable-dev-shm-usage"] if executable else [],
        )
        try:
            page = browser.new_page(viewport={"width": 1440, "height": 1000}, reduced_motion="reduce")
            for theme in THEMES:
                for mode in ("theme-dark", "theme-light"):
                    page.goto(FIXTURE.as_uri() + f"?theme={theme}&mode={mode}")
                    page.wait_for_function("document.documentElement.dataset.ready === 'true'")
                    page.screenshot(path=str(args.output_dir / f"{theme}-{mode}.png"), full_page=True)
                    print(f"Rendered fixture: {theme}, {mode}", flush=True)
        finally:
            browser.close()


if __name__ == "__main__":
    main()
