class Openpanda < Formula
  desc "Personal adaptive node-based distributed assistant (agent-of-agents)"
  homepage "https://github.com/Xustalis/OpenPanda"
  license "MIT"
  version "0.0.8"

  depends_on "python@3.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-arm64.tar.gz"
      sha256 "115467a5b4f4449f814a858e1deb7a284f84fa449fe7e28ed6ce25795ec8cdca"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-amd64.tar.gz"
      sha256 "03817ebcfba6282bed9f6a1ff45e663e7fc60c22471fcfea3641175129cc8c2c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-arm64.tar.gz"
      sha256 "2f93545b96a79cda7556c3544d5dfe3dbf1896f3626fa300531e300ba8b57d25"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-amd64.tar.gz"
      sha256 "0e7152676a8e98151c9cff42c6b99232733eb0a08752096a584bf9a80286feba"
    end
  end

  def install
    root = buildpath/"openpanda"
    root = buildpath unless root.directory?
    bin.install root/"bin/panda"
    (prefix/"adapters").install Dir[root/"adapters/*"]
    prefix.install root/"config.example.yaml"
    prefix.install Dir[root/"capabilities.example-*.yaml"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/panda version")
  end
end
