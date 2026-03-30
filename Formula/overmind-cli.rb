class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.17.3.tar.gz"
  sha256 "a0970e54eae2430db0d8eecb63dcc4c738eafe0702206c46e8abe6217a77e533"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0bd2abe033b42af990266b287268a4c4dd1e966eef9a7685305b575ce88355be"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5f800fa0060e14a5c8181458c1c76264ff5ced9981064989ef41ceb010400178"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "737e5e9c7fc7f028733aedcdff5e91358a08084029b15422c7f83f55aa327ca6"
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
