# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Static marketing website for **nutrx**, a privacy-first iOS nutrient tracking app. Hosted on GitHub Pages at `nutrx.nutrx-labs.com` (see `CNAME`). There is no build step, bundler, or framework — just plain HTML/CSS/JS served directly.

## Development

Open any `.html` file in a browser to preview. No build, install, or serve commands needed.

## Site Structure

- `index.html` — Landing page (hero, feature showcase, phone mockup, privacy section, newsletter signup via Formspree, download CTA)
- `changelog.html` — Release timeline (version history with features/improvements/fixes)
- `privacy.html` — Privacy policy
- `support.html` — Support/contact page
- `nutrx_icon_1024.png` — App icon used across all pages
- `CNAME` — GitHub Pages custom domain (`nutrx.nutrx-labs.com`)

## Design System

Shared tokens, nav and footer-note styles live in `assets/site.css`; page-specific CSS is inlined per page. When making visual changes, maintain consistency across pages:

- **Fonts**: rounded display (`ui-rounded` / SF Pro Rounded on Apple devices, Nunito fallback via Google Fonts) + system sans body (`-apple-system`, DM Sans fallback). Headings are heavy (800) with tight tracking; `<em>` in headings is upright and green (`--green-ink`), never italic.
- **CSS variables** (defined once in `assets/site.css` `:root`): `--bg: #F2F4EF`, `--text: #0E1A13`, `--text-2: #56655C`, `--accent: #1B3B2D` (forest, from the app icon), `--green: #1EB955` (fills/rings only — use `--green-ink: #137A3A` for green text), `--bg-dark: #1B3B2D`, `--orange: #E08A1E`, `--display`, `--sans`, `--r: 22px`, plus nutrient tints `--t-*`. Matches the app redesign (rings, forest hero cards, soft white cards).
- **Nav**: Shared structure across pages — logo + icon on left, action on right. All pages use a floating pill nav with blur; subpages use the subpage variant with "← Back" link
- **Animations**: `.fu` class + IntersectionObserver for scroll-triggered fade-up (index.html only)

## Key Integration

- **Newsletter**: Formspree endpoint (`https://formspree.io/f/mreyjklg`) — POST with `{email}`, JSON content type
- **App Store**: Apple App Store link with marketing tools badge (app ID: `6760843478`)
