class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.17.3.tar.gz"
  sha256 "a0970e54eae2430db0d8eecb63dcc4c738eafe0702206c46e8abe6217a77e533"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0bc673e982dbf1c6a43815ec4b6af6b25da5720a038189e14e882d733cb6cacd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1a800677e5f23f06cdf71d46128a2961af519066663f215e3d2f9d25cff9d02b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f7cbdf265d2b603676a100349204136acac9929ca0512458797b386d9530d54"
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
