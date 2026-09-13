cask "speedcrunch" do
  arch arm: "arm64", intel: "x86_64"

  version "sc-05d4f0f7"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "0000000000000000000000000000000000000000000000000000000000000000"

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

