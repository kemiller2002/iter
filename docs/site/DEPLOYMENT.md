# Iter Site Deployment

Status: planned.

The eventual public site should follow the Echelon Foundry GitHub Pages deployment pattern.

## Requirements

- Source lives under a dedicated `site/` tree.
- Build output is isolated from the NuGet package.
- GitHub Actions builds and validates the site before deployment.
- Deployment uses GitHub Pages.
- The custom domain should follow the Echelon Foundry domain convention when assigned.
- Forma and Limen versions used by the site are pinned and independently upgradeable from the Iter NuGet package.
- Site validation checks internal links, required metadata, accessibility basics, and published version claims.
- No site JavaScript or WASM is added without a demonstrated interaction need.
- A static page is preferred to runtime machinery whenever it can express the requirement.
