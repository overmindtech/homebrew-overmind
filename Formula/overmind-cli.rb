class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "cfaba4d3588bfcecf3c5e2ebfcc0c514ca93aa4ea712d451f113b1d06c7d615b"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "df590391cd71c6c2c221c88fe4ad7f839b905c61d30f294dc8f27fd085d84207"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e6d67dff78deabf04dbf7664e0f063858c16a2653b8cebaa7745e4ad551d29f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aba8a35ff694aa0b6cb41225b066e1cfb56db96e1f8e227198c528572ad1a63f"
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
