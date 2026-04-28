class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.17.8.tar.gz"
  sha256 "e1413412fefcc637772f5f102264a9bb15967f8fcd3fc6c43562f48f3890d3b5"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d6dd3d97f1c7b3060c1eeee37290de0dad6af2d1889b234b47f7aa5b6b4d907c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dc370707e09b5837b15e74cd8eefdf484fa2125847546465e2457b0ec608ae6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "242083b1a3ab887ed3c5651c9f574f4fa220215de5b2459208d9c2063e9bc722"
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
