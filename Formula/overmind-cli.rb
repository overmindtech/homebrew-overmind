class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.7.1.tar.gz"
  sha256 "f353b87fd94b8bd55424971e0fa50e8fcf38c59720bd264ade31241403c936c3"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9306e4b8ffe9e820e36bd40ba0c81d207ff9a604a478f31fb9be5fdf0acd3be0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4f842fcb1c96ab947077376168312cf3b52a74739868f477e377b85de5d11a1d"
    sha256 cellar: :any_skip_relocation, ventura:       "85e522e28a8813ef784ef714c5dcdbcfbd70fac66fa6fffa4c08931e47d2a9bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7b2c7db4ae7dfc87dfcb0ea63c61142e918ea63b3ffb7f0435089b21ee7aaed"
  end

  depends_on "go" => :build

  def install
    # Compile the correct version into the binary
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/overmindtech/cli/tracing.version=v#{version}-brew", output: "overmind")

    bin.install "overmind"
  end

  test do
    system "#{bin}/overmind", "--version"
  end
end
