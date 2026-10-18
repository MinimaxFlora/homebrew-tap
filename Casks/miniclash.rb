cask "miniclash" do
  version "0.1.3"

  on_macos do
    arch arm: "arm64", intel: "amd64"

    sha256 arm:   "ce5020957d04a2c0c59301de9f286e0d90496be5a8653552a17e86e8b0b960b5",
           intel: "99dfcdc6a05aa3db1e2199be0855496f106505d8795f16184c387a6c6a308a42"

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
