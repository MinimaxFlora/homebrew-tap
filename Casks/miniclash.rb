cask "miniclash" do
  version "0.1.2"

  on_macos do
    arch arm: "arm64", intel: "amd64"

    sha256 arm:   "97411a57629cdd941be264d477ee9806a6c9bcad5106934f0c2ff89d15e17d6a",
           intel: "883790edc8f340f995ae4159fb3e281abdaf6457e892989f6da36cdf575ef575"

    url "https://github.com/MinimaxFlora/MiniClash/releases/download/v#{version}/MiniClash-#{version}-macos-#{arch}.dmg"
  end

  name "MiniClash"
  desc "Multi-platform proxy client based on ClashMeta"
  homepage "https://github.com/MinimaxFlora/MiniClash"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "MiniClash.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-rd", "com.apple.quarantine", "{{appdir}}/MiniClash.app"],
        writable_paths: ["MiniClash.app"],
        writable_base:  :appdir
  end

  uninstall quit: "com.minimaxflora.miniclash"

  zap trash: [
    "~/Library/Application Support/com.minimaxflora.miniclash",
    "~/Library/Caches/com.minimaxflora.miniclash",
    "~/Library/Preferences/com.minimaxflora.miniclash.plist",
    "~/Library/Saved Application State/com.minimaxflora.miniclash.savedState",
  ]
end
