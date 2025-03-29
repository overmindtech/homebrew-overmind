class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.7.8.tar.gz"
  sha256 "2f7d0a4d528330221ea525042354cc8fea85c99098add5a8b1f632ceb7a72d86"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3b1c8172f990b8a13d25d2ce100f3c69507eba8b91f19c61759a2d5983f300f4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4714941b033a2edeea230e8cc14cbd43335a3863eaed2a4a50614269bc4aa1b6"
    sha256 cellar: :any_skip_relocation, ventura:       "c1f574e9978ae35d2ce455630a30004edd77b63d969dc5a3c9c151277b8e1900"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "474016e2cc1ff7adf6deaee7921b0fb1d5ac3a84421babd2bec4e836fc8ef4e3"
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
