class Openpanda < Formula
  desc "Personal adaptive node-based distributed assistant (agent-of-agents)"
  homepage "https://github.com/Xustalis/OpenPanda"
  license "AGPL-3.0-or-later"
  version "0.1.4"

  depends_on "python@3.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-arm64.tar.gz"
      sha256 "23b717f05273cbeb3a5b5af92779585b68e34329bd7b40ea007d62f6225d6a93"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-amd64.tar.gz"
      sha256 "2f2ac9ece065b1241f7a3752bdf8632fbbde3da7504a1d8dfce5db4dc39be76d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-arm64.tar.gz"
      sha256 "65622b6e662e0540da82a380e28ba1c2b3a6dea8aa05ae4d12226bd6b8e0a53f"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-amd64.tar.gz"
      sha256 "e7e62c3c30c41651f31ec76bbe204fb0c173784659515723400085ed7411b39d"
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
