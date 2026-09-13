# SpeedCrunch Personal Packaging Plan

## Goal

Create a single public GitHub repository that pins a known-good upstream SpeedCrunch commit and provides low-maintenance deployment for macOS and Linux.

The repository is not a SpeedCrunch fork and does not intend to maintain upstream development. It only packages one preferred upstream snapshot.

## Repository Layout

```text
homebrew-speedcrunch/
├── speedcrunch/                         # upstream git submodule, pinned commit
├── Casks/
│   └── speedcrunch.rb                   # personal Homebrew cask
├── flatpak/
│   └── org.speedcrunch.SpeedCrunch.yaml
├── site/
│   └── index.html                       # minimal GitHub Pages landing page
├── .github/
│   └── workflows/
│       ├── macos-release.yml
│       ├── flatpak-release.yml
│       └── pages.yml
├── README.md
└── .gitmodules
```

Repository name should remain `homebrew-speedcrunch` so Homebrew supports:

```bash
brew tap USER/speedcrunch
brew install --cask speedcrunch
```

## Source

Add the active upstream SpeedCrunch repository as a git submodule.

Pin it to the exact commit already tested locally with Qt 6.

No patches are currently required.

Updating SpeedCrunch should only require moving the submodule pointer:

```bash
cd speedcrunch
git fetch
git checkout <desired-commit>
cd ..
git add speedcrunch
git commit -m "Bump SpeedCrunch snapshot"
```

## macOS Build

Use GitHub Actions hosted macOS runners.

Build dependencies should come from Homebrew, not MacPorts:

```bash
brew install qt cmake ninja
```

Configure SpeedCrunch against Homebrew Qt 6.

After building:

1. Produce `SpeedCrunch.app`.
2. Run Qt 6 `macdeployqt` to bundle Qt frameworks/plugins.
3. Package as DMG or ZIP.
4. Upload resulting binary to a GitHub Release.

Prefer separate ARM64 and x86_64 artifacts initially rather than introducing universal-binary complexity.

Example release naming:

```text
SpeedCrunch-<snapshot>-macos-arm64.dmg
SpeedCrunch-<snapshot>-macos-x86_64.dmg
```

No Apple Developer account/signing/notarization is required for the initial personal setup.

## Homebrew

Maintain `Casks/speedcrunch.rb` in the same repository.

The cask should:

- select the correct GitHub Release artifact by CPU architecture;
- contain SHA256 values for each artifact;
- install `SpeedCrunch.app`;
- point its homepage to the repository or minimal project page.

Target deployment:

```bash
brew tap USER/speedcrunch
brew install --cask speedcrunch
```

Updates should work through normal Homebrew commands:

```bash
brew update
brew upgrade --cask speedcrunch
```

## Flatpak

Use the existing SpeedCrunch Flatpak manifest as a reference, but point its source at the pinned upstream commit used by this repository.

Build using GitHub Actions on Linux with `flatpak-builder`.

Use a Qt 6-compatible Flatpak runtime/SDK.

Publish the resulting OSTree Flatpak repository via GitHub Pages.

Also generate a `.flatpakref` for convenient installation.

Target deployment should be approximately:

```bash
flatpak remote-add --if-not-exists --user speedcrunch \
  https://USER.github.io/homebrew-speedcrunch/repo/

flatpak install speedcrunch org.speedcrunch.SpeedCrunch
```

or installation via the hosted `.flatpakref`.

Subsequent updates should work through:

```bash
flatpak update
```

## GitHub Pages

Use the same repository for both:

- a minimal human-facing landing page;
- the hosted Flatpak repository.

Expected published structure:

```text
https://USER.github.io/homebrew-speedcrunch/
├── index.html
├── speedcrunch.flatpakref
└── repo/
    ├── config
    ├── summary
    ├── refs/
    └── objects/
```

The landing page only needs to explain:

- this is a personal packaged snapshot of upstream SpeedCrunch;
- which upstream commit is currently pinned;
- Homebrew installation;
- Flatpak installation;
- link to upstream SpeedCrunch.

Avoid presenting the repository as a new upstream project.

## CI / Release Flow

Desired flow:

```text
Pinned SpeedCrunch submodule
          │
          ├───────────────┐
          │               │
     macOS Actions    Linux Actions
          │               │
     Homebrew Qt 6     Flatpak Qt 6
          │               │
     SpeedCrunch.app   Flatpak build
          │               │
      macdeployqt      OSTree export
          │               │
      DMG / ZIP       GitHub Pages
          │
    GitHub Release
          │
    Homebrew cask
```

Initially trigger builds manually or on version tags rather than on every push.

A simple snapshot tag scheme is sufficient, for example:

```text
snapshot-2026-08-18
```

or:

```text
sc-<short-upstream-commit>
```

## Implementation Order

- [x] Create `homebrew-speedcrunch` repository.
- [x] Add upstream SpeedCrunch as pinned submodule.
- [ ] Reproduce the known-good Qt 6 build using Homebrew Qt on a GitHub macOS runner.
- [ ] Add `macdeployqt` and produce a self-contained `.app`.
- [ ] Package and publish macOS release artifacts.
- [x] Create architecture-aware Homebrew cask.
- [ ] Verify clean-machine Homebrew installation.
- [x] Add Flatpak manifest using the same pinned upstream commit.
- [ ] Build Flatpak successfully in GitHub Actions.
- [ ] Export and publish Flatpak OSTree repository to GitHub Pages.
- [x] Generate `.flatpakref`.
- [x] Add minimal GitHub Pages landing page.
- [ ] Test installation and update flow on fresh macOS and Linux environments.

## Non-Goals

Do not add complexity unless required.

Specifically, avoid for now:

- maintaining a SpeedCrunch fork;
- carrying source patches;
- changing the application ID;
- Apple signing/notarization;
- universal macOS binaries;
- sophisticated website tooling;
- automatic tracking of upstream HEAD;
- publishing through official Homebrew or Flathub.

The repository should remain a small, reproducible deployment wrapper around a deliberately chosen upstream SpeedCrunch commit.
