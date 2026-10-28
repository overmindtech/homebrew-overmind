class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.6.tar.gz"
  sha256 "63926a563b0ea072809f9d4bb57229643cccbe0c422218f87743c784fbda6da6"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7739a96ae935245af10195089af9d5b5e0b57ab7d2f04ac25630b8beb2798364"
    sha256 cellar: :any,                 x86_64_linux:  "d98d3129bd6dc7bef3dec67437db37ad4d1f91f976721510841c5ae5e125a311"
  end

  depends_on "go" => :build

  def install
    # Compile the correct version into the binary
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/overmindtech/cli/tracing.version=v#{version}", output: "overmind")

    bin.install "overmind"
  end

  test do
    system "#{bin}/overmind", "--version"
  end
end
