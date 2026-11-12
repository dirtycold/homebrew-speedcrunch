cask "speedcrunch@upstream" do
  arch arm: "arm64", intel: "x86_64"

  version "upstream-v1.1.0"
  sha256 arm:   "af115cd082d7a20e462163e5b69548eac6b6cc29b2810d164314c02f8a465514",
         intel: "0cceeb4725b2df416b60b414435868a26830b0057780ae0c075386ed1c51fbb9"

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

