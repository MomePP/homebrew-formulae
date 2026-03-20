class Mocv < Formula
  desc "OpenCode with Vim keybindings - AI coding assistant for the terminal"
  homepage "https://github.com/leohenon/opencode"
  version "1.2.27-vim.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/leohenon/opencode/releases/download/v1.2.27-vim.2/ocv-darwin-arm64.zip"
      sha256 "602b1e5a05d19cd61a85f935168165e43bf87bee322f73f039e87784d9df4b22"
    else
      url "https://github.com/leohenon/opencode/releases/download/v1.2.27-vim.2/ocv-darwin-x64.zip"
      sha256 "e6fb1cbc9fc4be897a39d9d465afcdf2811cf8725a3639aa44b7569abd10e0d3"
    end
  end

  def install
    bin.install "opencode" => "ocv"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ocv --version", 2)
  end
end
