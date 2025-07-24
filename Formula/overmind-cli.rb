class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.8.6.tar.gz"
  sha256 "d8fbe3712f15064a482b9384e74b7552965e1401510e36fcb8549e92188cca9d"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "50a3a6b0fb28843d7e867029faf9c30c12b1cc68882d4dad4cc304d90f840929"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d187910bd9076637382fe49acd8b60d810fdcdcacec1f14d356bda9aaec7047e"
    sha256 cellar: :any_skip_relocation, ventura:       "9bd3da1466821f6e12c8e1dc4aaa97314c85cbac65f9d0aa9d7fb816cb6eaceb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "071e9385e2273d1d811868a40bb8c9b3a94855fe0f372b557b10f49184dab8fd"
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
