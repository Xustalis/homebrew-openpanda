class Openpanda < Formula
  desc "Personal adaptive node-based distributed assistant (agent-of-agents)"
  homepage "https://github.com/Xustalis/OpenPanda"
  license "AGPL-3.0-or-later"
  version "0.1.0"

  depends_on "python@3.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-arm64.tar.gz"
      sha256 "3d5e2965fa5a4c4589861242f2ac646ff9f969e4cb4f74cc786638246eaad4f3"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-amd64.tar.gz"
      sha256 "d85286156c8bc6205c98864bb139ecd85c5a125fd52c69cfb7cf467268421ff7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-arm64.tar.gz"
      sha256 "9dc11d77e3eb04b2416b28335852f2a74da21e7ffbbe8dff059040fa0264ffd1"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-amd64.tar.gz"
      sha256 "f442996ab380126106192e7a05e15c4a4e0d54932caf2faa6648e1656dc910cc"
    end
  end

  def install
    root = buildpath/"openpanda"
    root = buildpath unless root.directory?
    bin.install root/"bin/panda"
    (prefix/"adapters").install Dir[root/"adapters/*"]
    # Voice sidecars too: `panda voice` resolves <prefix>/extensions/voice
    # beside the real (Cellar) binary.
    (prefix/"extensions/voice").install Dir[root/"extensions/voice/*"]
    prefix.install root/"config.example.yaml"
    prefix.install Dir[root/"capabilities.example-*.yaml"]
    pkgshare.install root/"LICENSE", root/"NOTICE", root/"COMMERCIAL.md", root/"THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/panda version")
  end
end
