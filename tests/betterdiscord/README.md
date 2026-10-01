# BetterDiscord theme verification

The deployable files live at:

- `sakura-season/BetterDiscord/themes/sakura-season.theme.css`
- `violet-evergarden/BetterDiscord/themes/violet-evergarden.theme.css`

They do not depend on this test directory, Python, Playwright or any external CSS. Each file is independently copy-deployable into BetterDiscord's themes directory.

## Representative preview

Open `preview.html` directly in a browser. The theme and appearance selectors load the actual deployable CSS files. The fixture models token consumers and selected DOM patterns; it is **not** a captured/live Discord client or an exhaustive replica of Discord.

To save dark and light screenshots for both themes (after installing the test dependencies):

```bash
.venv-betterdiscord/bin/python tests/betterdiscord/render_preview.py \
  --output-dir /path/to/preview-output
```

The renderer also accepts `--browser /path/to/chrome`.

## Repeatable checks

From the repository root:

```bash
python3 -m venv .venv-betterdiscord
.venv-betterdiscord/bin/pip install -r tests/betterdiscord/requirements.txt
.venv-betterdiscord/bin/python -m pytest tests/betterdiscord/test_themes.py -q
```

The suite uses a locally installed `chromium`/`chromium-browser` if available. To choose another executable explicitly:

```bash
BETTERDISCORD_TEST_BROWSER=/path/to/chrome \
  .venv-betterdiscord/bin/python -m pytest tests/betterdiscord/test_themes.py -q
```

If there is no system browser, install Playwright's browser:

```bash
.venv-betterdiscord/bin/python -m playwright install chromium
```

If Playwright's bundled Node driver cannot start on your environment, set `PLAYWRIGHT_NODEJS_PATH` to a verified working Node executable. Do not modify your desktop browser profile; tests launch a separate headless browser with temporary profiles.

For parser/metadata and deployment checks without launching a browser:

```bash
.venv-betterdiscord/bin/python -m pytest tests/betterdiscord/test_themes.py \
  -q -k 'standalone_metadata or copy_deployment'
```

## Coverage and limits

- Required BetterDiscord metadata at the beginning of each file; CSS rule/declaration parsing.
- No network-loaded CSS/assets and no fixed Discord class hashes.
- Both palettes in Dark, Darker, Midnight and Light appearance classes.
- Computed body, muted, sidebar, menu, link and brand-button text contrast of at least 4.5:1 in the fixture.
- Legacy and current primary-control token families.
- Channel selection, mention markers, reactions, composer editing and focus indicators.
- Reduced-motion handling and native high-contrast/forced-colors opt-out.
- No horizontal overflow in the preview at tested desktop widths.
- Copy-tree deployment without changing the original files.

Presence indicators, role colors and critical/danger controls are deliberately not recolored. The tests verify representative presence and danger consumers stay native.

No logged-in BetterDiscord client is used by these tests. After copying the theme into your real client, check channels, DMs, settings, search/autocomplete, popouts, voice controls and actual message reactions. If Discord changes its class stems, the semantic palette should retain broad coverage but optional finishing details may need maintenance.

## Reference sources

- [BetterDiscord theme structure and required metadata](https://docs.betterdiscord.app/themes/introduction/structure)
- [BetterDiscord quick start and theme directory](https://docs.betterdiscord.app/themes/introduction/quick-start)
- Public CSS linked from [Discord's app shell](https://discord.com/app), inspected for modern `background-base-*`, `interactive-*`, `control-primary-*` and `message-*` tokens. This repository does not vendor Discord's stylesheets.
