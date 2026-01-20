class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.13.1.tar.gz"
  sha256 "a4010ecda50ec1f060a1a4afb3c119bc17cce760aaa95dfe06bf32ca577bfe20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d0dc05a5dd1eadffd7e1be5aa93ed4ecc9efc4f7f2214233434307181b44e79b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "514ac56244495df4f3e99ad763d3c8e4aeb0c851e6b9d4e125823d30be55a785"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "02f32a960944c08c1440bf26ac5d9145fac5cc9b1dac7985671772342e6f957a"
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
