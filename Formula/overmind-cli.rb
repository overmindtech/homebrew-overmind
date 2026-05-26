class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.18.2.tar.gz"
  sha256 "e427fc6a0d40b836de0a2463aa584d1c40f3675556ef02bf6561ce1e1d6a5b1a"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e7c4ef6a5cf62f54cf8cf11313c27dfb12d789123332279bd213888757a919ca"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9b109a23427b4bc16b329f2670169359180f13e2f44b47807377763b3245d683"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28359f8abade74578d526d2fa00b1d1a7a22c38485528a86cc9a0a94c4dc9e78"
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
