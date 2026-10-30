class Openpanda < Formula
  desc "Personal adaptive node-based distributed assistant (agent-of-agents)"
  homepage "https://github.com/Xustalis/OpenPanda"
  license "AGPL-3.0-or-later"
  version "0.1.3"

  depends_on "python@3.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-arm64.tar.gz"
      sha256 "991abad305705de00e92ce29dc781469978fa1cf264bf1345d4316061bb249e0"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-amd64.tar.gz"
      sha256 "4e83af627246f56afd5e0644221aba022954c7139873359e8ec7c37727777ffe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-arm64.tar.gz"
      sha256 "1345c13c3a426b5a73393f53e81a5daa15afadb0ba6e1ee3759428fa58925c45"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-amd64.tar.gz"
      sha256 "c2682ed412cc304ddb732d596c0badbcca787b30683cf2db750863d39b411150"
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
