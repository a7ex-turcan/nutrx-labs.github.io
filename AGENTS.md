# Repository Guidelines

## Project Structure & Module Organization
This repository is a static GitHub Pages marketing site for the nutrx iOS app at `www.nutrx-labs.com`. There is no framework or build pipeline.

- `index.html`: landing page and primary marketing content
- `changelog.html`: release history
- `privacy.html`: privacy policy
- `support.html`: support/contact page
- `nutrx_icon_1024.png`: shared app icon asset
- `CNAME`: custom domain for GitHub Pages
- `CLAUDE.md`: existing repo notes for coding agents

Each page contains its own inline CSS and page-specific JavaScript. Keep navigation, typography, and palette decisions aligned across pages.

## Build, Test, and Development Commands
No install, build, or bundling step is required.

- `open index.html`: preview the landing page locally in a browser
- `python3 -m http.server 8000`: serve the site locally if browser security or relative asset loading matters
- `git diff -- index.html`: review page edits before committing

## Coding Style & Naming Conventions
Use plain HTML, CSS, and minimal vanilla JavaScript. Follow the existing style:

- 2-space indentation in HTML, CSS, and JS
- lowercase file names such as `privacy.html`
- descriptive class names like `hero-badge` or `nav-logo-text`
- reuse existing CSS variables, fonts, and spacing patterns before introducing new ones

Prefer the existing design system: `Fraunces` for display text, `DM Sans` for body copy, and shared `:root` variables such as `--bg`, `--text`, `--text-2`, `--accent`, `--green`, `--orange`, and `--r`. `index.html` uses the fixed blurred nav and `.fu` reveal animation; subpages use a simpler back-link nav.

There is no configured formatter or linter, so keep edits small and consistent with surrounding code.

## Testing Guidelines
There is no automated test suite. Validate changes manually in a browser.

- check edited pages on desktop and mobile widths
- verify navigation links, anchors, and external links
- confirm forms and CTA targets still point to the correct endpoints
- inspect for layout regressions, especially where CSS is duplicated across pages

Check the Formspree newsletter endpoint in `index.html` and the Apple App Store badge/link for app ID `6760843478`.

## Commit & Pull Request Guidelines
Recent commits use short imperative summaries, for example `Add the privacy page` and `Update version tag to v1.4 on landing page`.

- keep commit subjects concise and action-first
- group related page/content changes into a single commit
- in PRs, include a brief summary, affected pages, and screenshots for visual changes
- link the relevant issue or task when one exists

## Deployment & Content Notes
Changes pushed to the default branch deploy through GitHub Pages. Treat `privacy.html` and `support.html` edits carefully, and preserve production endpoints, domain settings, and contact links unless needed.
