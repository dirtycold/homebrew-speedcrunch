cask "speedcrunch" do
  arch arm: "arm64", intel: "x86_64"

  version "sc-05d4f0f7"
  sha256 arm:   "26e02d7e6fdfa1891c8ec9f41bad167a402deaf33b9c84f784cead5ecf7eba50",
         intel: "3f31bb7e267db5a451a53283698fa7cbaa4c8bbf141d9522233ba521d12dbee5"

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

