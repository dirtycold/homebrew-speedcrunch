# SpeedCrunch snapshot packaging

Personal macOS and Linux packages for upstream [SpeedCrunch](https://bitbucket.org/heldercorreia/speedcrunch/), pinned as a submodule at commit `05d4f0f78e2b0646c4529adb1dad2453b378c736`. This repository is packaging only; it is not a SpeedCrunch fork.

## macOS with Homebrew

```sh
brew tap dirtycold/speedcrunch
brew install --cask speedcrunch
```

The initial cask checksums are placeholders. Run the **macOS release** workflow with tag `sc-05d4f0f7`; it builds native ARM64 and Intel DMGs, publishes them to a GitHub Release, and commits their SHA-256 values to the cask. The app is ad-hoc signed but not Apple-notarized.

## Linux with Flatpak

After the **Flatpak release** workflow has published GitHub Pages:

```sh
flatpak remote-add --if-not-exists --user --no-gpg-verify speedcrunch \
  https://dirtycold.github.io/homebrew-speedcrunch/repo/
flatpak install --user speedcrunch org.speedcrunch.SpeedCrunch
```

Alternatively, open <https://dirtycold.github.io/homebrew-speedcrunch/speedcrunch.flatpakref>.
The personal OSTree repository is currently unsigned, so the command explicitly disables GPG verification.

## Updating the snapshot

Move the `speedcrunch` submodule to a deliberately selected upstream commit, then update the pinned commit shown in the manifest, site, release notes, cask version, and this README. Tag the packaging commit using `sc-<short-commit>` and run the release workflows.

## Local Flatpak build

```sh
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub org.kde.Platform//6.10 org.kde.Sdk//6.10
flatpak-builder --user --force-clean --repo=.flatpak-repo build-flatpak \
  flatpak/org.speedcrunch.SpeedCrunch.yaml
```
