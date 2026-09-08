class Openpanda < Formula
  desc "Personal adaptive node-based distributed assistant (agent-of-agents)"
  homepage "https://github.com/Xustalis/OpenPanda"
  license "MIT"
  version "0.0.8"

  depends_on "python@3.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-arm64.tar.gz"
      sha256 "216f99852bc0046aba3a83f8cd9d0bcff9044a355a165d6dfa3f159ffa4ef959"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-darwin-amd64.tar.gz"
      sha256 "f82ebbb0aa783839a87d3a7a525732679788aaf1cab7ab489b1f9eaf5eeb0964"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-arm64.tar.gz"
      sha256 "64ec579b79870d3e6488cf52fec2b21e9c687df3bea5f4d37bbbb1636a3f6a11"
    else
      url "https://github.com/Xustalis/OpenPanda/releases/download/v#{version}/panda-#{version}-linux-amd64.tar.gz"
      sha256 "df0df60d577c36469881fd2c59aa7e9e119c694a19b0720521ca8f33b1442216"
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
