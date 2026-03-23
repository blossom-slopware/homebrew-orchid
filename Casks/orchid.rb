cask "orchid" do
  version "0.0.3"
  sha256 "d6cb1178c801e2a58c5f116bcd39038ceb1bf1d02805ef4d6ef70fea6616a8fc"

  url "https://github.com/blossom-slopware/orchid/releases/download/v#{version}/Orchid-#{version}.zip"
  name "Orchid"
  desc "Screenshot OCR powered by GLM-OCR"
  homepage "https://github.com/blossom-slopware/orchid"

  app "Orchid.app"

  # Expose the bundled inference server binary to PATH
  binary "Orchid.app/Contents/Resources/bin/glm-ocr-server"

  postflight do
    # Remove macOS quarantine flag added when downloading from the internet.
    # Required because Orchid.app is not notarized (no Apple Developer account).
    system_command "/usr/bin/xattr",
      args: ["-cr", "#{appdir}/Orchid.app"],
      sudo: false
  end

  uninstall quit: "daisy.orchid"

  zap trash: [
    "~/.orchid",
    "~/Library/Logs/Orchid",
  ]
end
