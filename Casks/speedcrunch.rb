cask "speedcrunch" do
  arch arm: "arm64", intel: "x86_64"

  version "sc-05d4f0f7"
  sha256 arm:   "b3b93a370bfbd756ddc7df99ccad980055680d2e2964b6433f0a84bcaedce74e",
         intel: "6086897d489abae00eb200a02676f16b920759f134cfcb5554000f3cbcc71a2d"

  url "https://github.com/dirtycold/homebrew-speedcrunch/releases/download/#{version}/SpeedCrunch-#{version}-macos-#{arch}.dmg"
  name "SpeedCrunch"
  desc "High-precision scientific calculator"
  homepage "https://dirtycold.github.io/homebrew-speedcrunch/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "SpeedCrunch.app"

  caveats <<~EOS
    This personal snapshot is not signed or notarized. On first launch, use
    Control-click > Open if macOS Gatekeeper blocks it.
  EOS
end

