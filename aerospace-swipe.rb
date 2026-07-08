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
    prefix.install "accessibility.entitlements"
  end

  service do
    run [opt_prefix/"AerospaceSwipe.app/Contents/MacOS/AerospaceSwipe"]
    keep_alive true
    process_type :interactive
    log_path var/"log/aerospace-swipe.log"
    error_log_path var/"log/aerospace-swipe.log"
  end

  def caveats
    <<~EOS
      Homebrew builds this app ad-hoc signed (its install sandbox can't read
      your keychain), so macOS invalidates Accessibility permission on every
      `brew upgrade`: the prompt reappears but the app vanishes from System
      Settings > Privacy & Security > Accessibility.

      For a grant that survives upgrades: from a checkout of the repo, run
      `./setup-codesign-identity.sh` once to create a local signing identity,
      then after every `brew upgrade aerospace-swipe` run:
        codesign --force --sign "AerospaceSwipe Local Signing" \\
          --entitlements #{opt_prefix}/accessibility.entitlements \\
          #{opt_prefix}/AerospaceSwipe.app
        brew services restart aerospace-swipe

      The next launch after that (or after `tccutil reset Accessibility
      com.example.swipe`) will need one fresh Accessibility grant — after
      that it persists across upgrades as long as you re-run the codesign
      command above each time.
    EOS
  end

  test do
    assert_path_exists prefix/"AerospaceSwipe.app/Contents/MacOS/AerospaceSwipe"
  end
end
