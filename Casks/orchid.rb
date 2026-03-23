cask "orchid" do
  version "0.0.4"
  sha256 "b66957291bea0bccb389ccfeaae1511cadea66b700f113cc0ae7d19d2fa06ba0"

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
