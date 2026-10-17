cask "miniclash" do
  version "0.1.0"

  on_macos do
    arch arm: "arm64", intel: "amd64"

    sha256 arm:   "a41de6c5ad25a003949a35ac550d3aa5d7943b0e26f30d38b63879a0c6619f91",
           intel: "713f6bb012b70eecca5736b0336659f4f31c1d9b148ae1cd727cbb07e505c5d6"

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
