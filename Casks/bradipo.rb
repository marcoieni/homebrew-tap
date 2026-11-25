cask "bradipo" do
  version "0.1.0"
  sha256 "ac92caa08e15d8e2f746c5e503ac6a0a891ca90c636656d8da19770f35f379aa"

  url "https://github.com/marcoieni/bradipo/releases/download/v#{version}/bradipo-#{version}.dmg"
  name "bradipo"
  desc "Menu bar break reminder"
  homepage "https://github.com/marcoieni/bradipo"

  depends_on arch: :arm64
  # bradipo needs macOS 27.2.1, but depends_on can only name major releases.
  depends_on macos: :golden_gate

  app "bradipo.app"

  # bradipo isn't notarized, so macOS would block each new version until users
  # allow it in System Settings.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/bradipo.app"]
  end

  uninstall quit: "com.marcoieni.bradipo"

  zap trash: "~/Library/Preferences/com.marcoieni.bradipo.plist"

  caveats <<~EOS
    bradipo requires macOS 27.2.1 or later.

    It isn't notarized by Apple. This cask removes its quarantine, so macOS
    opens it without Gatekeeper's check.
  EOS
end
