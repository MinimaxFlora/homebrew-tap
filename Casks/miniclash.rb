cask "miniclash" do
  version "0.1.1"

  on_macos do
    arch arm: "arm64", intel: "amd64"

    sha256 arm:   "6a4f1b33f0ba52e21198a0291c5a36462abf2e9953fdc4a6f5a3c9b953531667",
           intel: "e5f0bfd671e6e05fa677ff83d04c9a4b34a7cdbcd9188aebb907cb4558f48473"

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
