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

  conflicts_with cask: "speedcrunch@upstream"

  app "SpeedCrunch.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SpeedCrunch.app"],
                   must_succeed: true
  end

  caveats <<~EOS
    This personal snapshot is ad-hoc signed but not notarized.
    Quarantine is removed automatically during installation.
  EOS
end

