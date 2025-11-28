class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.10.4.tar.gz"
  sha256 "eff9c4f97e06066da6c8c8fac0823c2f18e265ff663f550fad265daee752c1c6"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "745df71f2a5324a055def420e5c7f407bfa5ea6914a6723f0d6c9611766a47fa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1682cc58b30055f58743c460e8150a63a7d4c951429de4d18e03f75c718113d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "41e0deef8be244dcc0e0808252fc4b31f5e4ff4994393605a2dbd19215ee3e65"
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
