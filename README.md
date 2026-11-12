# SpeedCrunch packaging

Personal macOS and Linux packages for upstream [SpeedCrunch](https://bitbucket.org/heldercorreia/speedcrunch/), pinned as a submodule at commit `05d4f0f78e2b0646c4529adb1dad2453b378c736`. This repository is packaging only; it is not a SpeedCrunch fork.

An alternative upstream build is pinned to release `v1.1.0`. The snapshot Flatpak build applies one packaging-only patch for a filename capitalization mismatch; the upstream build does not need it. The submodule itself remains unchanged.

## macOS with Homebrew

```sh
brew install --cask dirtycold/speedcrunch/speedcrunch
```

For upstream 1.1.0 instead, after its release workflow has published the cask:

```sh
brew install --cask dirtycold/speedcrunch/speedcrunch@upstream
```

Current Homebrew versions require explicit trust for third-party taps. Using the fully qualified cask name grants trust only to this cask; after installation, ordinary `brew upgrade --cask speedcrunch` works normally.

The **macOS release** workflow builds native ARM64 and Intel DMGs, publishes them to a GitHub Release, and commits their SHA-256 values to the cask. The app is ad-hoc signed but not Apple-notarized.

## Linux with Flatpak

After the **Flatpak release** workflow has published GitHub Pages:

```sh
flatpak remote-add --if-not-exists --user --no-gpg-verify speedcrunch \
  https://dirtycold.github.io/homebrew-speedcrunch/repo/
flatpak install --user speedcrunch org.speedcrunch.SpeedCrunch//stable
```

Alternatively, open <https://dirtycold.github.io/homebrew-speedcrunch/speedcrunch.flatpakref>.
The personal OSTree repository is currently unsigned, so the command explicitly disables GPG verification.

For upstream 1.1.0 instead, use `org.speedcrunch.SpeedCrunch//upstream` or open <https://dirtycold.github.io/homebrew-speedcrunch/speedcrunch-upstream.flatpakref>.

## Updating the snapshot

Move the `speedcrunch` submodule to a deliberately selected upstream commit, then update the pinned commit shown in the manifest, site, release notes, cask version, and this README. Tag the packaging commit using `sc-<short-commit>` and run the release workflows.

To release the pinned upstream build, push the packaging commit and tag `upstream-v1.1.0`. This triggers both release workflows. New upstream versions require updating the source pins and accepted release tag first.

## Local Flatpak build

```sh
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub org.kde.Platform//6.11 org.kde.Sdk//6.11
flatpak-builder --user --force-clean --repo=.flatpak-repo build-flatpak \
  flatpak/org.speedcrunch.SpeedCrunch.yaml
```
