class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.28.0.tar.gz"
  sha256 "2cbc8d693a25fe30ed4701fd4da2521897bcf06c89096c79e3354c1fbfbdfa3b"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "0a4561bf09b82e8047bba5508f0013b7b5d9a4595aafc9005d9c2c57bf653ca3"
    sha256 cellar: :any_skip_relocation, ventura:      "244d177ba19adee301a0199d73e849ca4e06d4e86555d7cfa5c6c1a0ffd6881a"
    sha256 cellar: :any_skip_relocation, monterey:     "785fd3e55f397cd0d95e3716dc1f1bface7dd6bfb90eb194ed5c7f7885d4e8a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4852869517dc5ee599c72c960a163170ec424346260ff5130adbdf38b0a4f9c0"
  end

  depends_on "go" => :build

  def install
    # Write the version of the package to a file so that it can be compiled into
    # the binary
    File.write("tracing/commit.txt", "v#{version}-brew")
    File.write("cmd/commit.txt", "v#{version}-brew")

    system "go", "build", *std_go_args(ldflags: "-s -w", output: "overmind")

    bin.install "overmind"
  end

  test do
    system "#{bin}/overmind", "--version"
  end
end
