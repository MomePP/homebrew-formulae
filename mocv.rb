class Mocv < Formula
  desc "OpenCode with Vim keybindings - AI coding assistant for the terminal"
  homepage "https://github.com/leohenon/opencode"
  version "1.2.27"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leohenon/opencode/releases/download/v1.2.27/ocv-darwin-arm64.zip"
      sha256 "eb355fdd654e710f9f73103052b50051cf321b07d66706ac2fe4ab61c7e5f6de"
    else
      url "https://github.com/leohenon/opencode/releases/download/v1.2.27/ocv-darwin-x64.zip"
      sha256 "326e60d32d4f13a60a23e94054ce1b5c2b462cdaff8554b487eee01c6fc5e5b7"
    end
  end

  def install
    bin.install "opencode" => "ocv"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ocv --version", 2)
  end
end
