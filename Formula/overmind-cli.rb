class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.7.6.tar.gz"
  sha256 "7ebfcce56c155d838929ef6224d0a942606edf6153d042beaa50e4147aafc380"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "70096613c0f7b5962e6cf35763d4bfd7b52b02c9376eeba6b634c9a31376702f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3773f2a9ff26fcf6ade52d51b22c35c7ee9085153f3abc9c0831caab7d9ec899"
    sha256 cellar: :any_skip_relocation, ventura:       "cb8b678b0017d24171097b224e4a4d00bbee28649daa491306f0da09bda3026e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6768fb88f9b54cfbb418909e3a829eadc9d63a776317fbb54b6ab2bd2d1598ea"
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
