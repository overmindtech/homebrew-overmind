class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.7.tar.gz"
  sha256 "2f662da2d43c95d64808ee3290a40f07e6bd78b84d7db81d73ae03aa8897c588"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8584e06525996b922c98d34c98946bd08164bb3d1c1bf8554cc1ac50a075b4d1"
    sha256 cellar: :any,                 x86_64_linux:  "6d6aa62ac300fdd3320966157eb8a1f892804d9f93ff95534e304fbb65e12e38"
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
