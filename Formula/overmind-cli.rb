class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.7.3.tar.gz"
  sha256 "c9582816c2e7bfb871d9561ff929455447059ef01cd63dc975a0b3e1872288d4"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3cf1016852c400c982f0a4fc46815af1a15852719248b052ef62f1a8354bcb21"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e1e462308cbeeb6db8a1b29cc16c350f5cb3f7a03ded187fadd5ecda43fe56b2"
    sha256 cellar: :any_skip_relocation, ventura:       "d0ef86534561853451da0dc1a6b7f1237247f31d3d8fcda72291cfe0186a42bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba349c28e043720266e915469d895105470d6a5fa10ec7b5958c6cbc5404f269"
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
