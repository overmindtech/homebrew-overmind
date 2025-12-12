class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.11.1.tar.gz"
  sha256 "ead600204e22b8587651226ba4a21c8e4c423522a0ca50bd57ab636ddb98706f"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "581dea0b75d1c1065753732d51227dc3b8a1619350b6cfd52c7039669c864fd1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "40293f1cbbf33600d976d95e5abed3ac67f6a8d654d6aa7f784a72976155545d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "24a1b0679563816403ec1db23fe7aa49648aecee7c58277a1ac708322c62b60e"
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
