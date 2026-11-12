cask "speedcrunch@upstream" do
  arch arm: "arm64", intel: "x86_64"

  version "upstream-v1.1.0"
  sha256 arm:   "ca4cc517e053510e8c5086cf5a823bec00c427ffcf24359a51341033af87c4f0",
         intel: "3695c21bbaf3c9fc592ad85f41c469e57d5f2274ea29ca37f197ed0dd213be28"

  url "https://github.com/dirtycold/homebrew-speedcrunch/releases/download/#{version}/SpeedCrunch-#{version}-macos-#{arch}.dmg"
  name "SpeedCrunch"
  desc "High-precision scientific calculator"
  homepage "https://dirtycold.github.io/homebrew-speedcrunch/"


  conflicts_with cask: "speedcrunch"

  app "SpeedCrunch.app"

  caveats <<~EOS
    This personal upstream build is not signed or notarized. On first launch, use
    Control-click > Open if macOS Gatekeeper blocks it.
  EOS
end

