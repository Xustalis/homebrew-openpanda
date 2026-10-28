class Openpanda < Formula
  desc "Personal adaptive node-based distributed assistant (agent-of-agents)"
  homepage "https://github.com/Xustalis/OpenPanda"
  license "AGPL-3.0-or-later"
  version "0.1.1"

  depends_on "python@3.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-arm64.tar.gz"
      sha256 "9eee0253da4813f0d52f4c3e1a38dee54ad7d782d1639c8f6dacee20918dbf6d"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-amd64.tar.gz"
      sha256 "70d2d13df68f98b0505b6dfd2e44dfff4239971c004fe98d775d6f03b971d811"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-arm64.tar.gz"
      sha256 "c1e96818a37660b041068f2d082925f2ab8958c9ce18c50c21c3f71312a8b54c"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-amd64.tar.gz"
      sha256 "68ccd8ad0f57a75786fd97aba055750f6030df896498314b4f68a7118c3ce1a4"
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
