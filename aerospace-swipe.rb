# typed: false

# frozen_string_literal: true

# aerospace-swipe.rb
class AerospaceSwipe < Formula
  desc "Trackpad swipe gestures for AeroSpace workspace switching"
  homepage "https://github.com/MomePP/aerospace-swipe"
  url "https://github.com/MomePP/aerospace-swipe.git",
      tag:      "v1.1.2",
      revision: "a5692d614befff0e177861dc5604c0e75b0b884a"
  license "MIT"
  head "https://github.com/MomePP/aerospace-swipe.git", branch: "main"

  depends_on :macos

  def install
    system "make", "bundle"
    prefix.install "AerospaceSwipe.app"
  end

  service do
    run [opt_prefix/"AerospaceSwipe.app/Contents/MacOS/AerospaceSwipe"]
    keep_alive true
    process_type :interactive
    log_path var/"log/aerospace-swipe.log"
    error_log_path var/"log/aerospace-swipe.log"
  end

  test do
    assert_path_exists prefix/"AerospaceSwipe.app/Contents/MacOS/AerospaceSwipe"
  end
end
