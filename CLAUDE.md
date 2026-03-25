# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Static marketing website for **nutrx**, a privacy-first iOS nutrient tracking app. Hosted on GitHub Pages at `www.nutrx-labs.com` (see `CNAME`). There is no build step, bundler, or framework — just plain HTML/CSS/JS served directly.

## Development

Open any `.html` file in a browser to preview. No build, install, or serve commands needed.

## Site Structure

- `index.html` — Landing page (hero, feature showcase, phone mockup, privacy section, newsletter signup via Formspree, download CTA)
- `changelog.html` — Release timeline (version history with features/improvements/fixes)
- `privacy.html` — Privacy policy
- `support.html` — Support/contact page
- `nutrx_icon_1024.png` — App icon used across all pages
- `CNAME` — GitHub Pages custom domain (`www.nutrx-labs.com`)

## Design System

All CSS is inlined per page (no shared stylesheet). When making visual changes, maintain consistency across pages:

- **Fonts**: Fraunces (display/headings) + DM Sans (body) via Google Fonts
- **CSS variables** (defined in each page's `:root`): `--bg: #F7F7F5`, `--text: #111111`, `--text-2: #6E6E73`, `--accent: #007AFF`, `--green: #34C759`, `--orange: #FF9F0A`, `--display`, `--sans`, `--r: 16px`
- **Nav**: Shared structure across pages — logo + icon on left, action on right. `index.html` uses a fixed/blur nav; subpages use a simpler static nav with "← Back" link
- **Animations**: `.fu` class + IntersectionObserver for scroll-triggered fade-up (index.html only)

## Key Integration

- **Newsletter**: Formspree endpoint (`https://formspree.io/f/mreyjklg`) — POST with `{email}`, JSON content type
- **App Store**: Apple App Store link with marketing tools badge (app ID: `6760843478`)
