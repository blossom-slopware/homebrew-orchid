cask "orchid" do
  version "0.0.1"
  sha256 "f0cbad5ddcf46aae8c2693487e4847641114741a27a2c8ceda847d772ab00c85"

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
