cask "speedcrunch" do
  arch arm: "arm64", intel: "x86_64"

  version "sc-05d4f0f7"
  sha256 arm:   "b65b8e46b02bbcf574fe6d4383861ecbd8a4b219ae520fc5d21ea3143cde4b0a",
         intel: "128a114c20af1b6678a2722113bfd830e4f25ef890d94d309d6681c00a97ccee"

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

