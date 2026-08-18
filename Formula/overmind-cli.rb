class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.1.tar.gz"
  sha256 "722fd73f9fa67924b4e071c0562325eb8d4129a55f95944d6fc52f7f4bc4d2ef"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "367e2dea9b8f90357efef995ccf59c38d1b6a8ca320d25a1ec32432bbbcb1ffd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5c476f5867971038e2e83a5b02d23cbfb55a5687f6288d2af3995510083fa9a9"
    sha256 cellar: :any,                 x86_64_linux:  "756391a0325a4e26a10a0f98e6817f18c8e5bcf1c8a2e0e15850a68a4f620c45"
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
