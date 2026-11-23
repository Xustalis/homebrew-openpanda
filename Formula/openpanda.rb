class Openpanda < Formula
  desc "Personal adaptive node-based distributed assistant (agent-of-agents)"
  homepage "https://github.com/Xustalis/OpenPanda"
  license "AGPL-3.0-or-later"
  version "0.1.7"

  depends_on "python@3.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-arm64.tar.gz"
      sha256 "b22787f74413a614dc9f58ca52211e0adaa2f33130d75a48f23a8e8da1bb8fe4"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-amd64.tar.gz"
      sha256 "aa16e57498697056f719f239e928ebcd47298de579db5f96dc1752a55f6cbeab"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-arm64.tar.gz"
      sha256 "436b88a02692d9d00863807c34ee573ddbb1e112fcf71ffda0a133a61493cb0d"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-amd64.tar.gz"
      sha256 "d04f1122d61389938b082da512abe8df4537c9556560aa3ff387296b924bc8e9"
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
