class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.8.1.tar.gz"
  sha256 "6ef1727b863913942f2c0f028303764a74c60ca9333ecb8ac1f53e9ef33543d6"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "43aa850ebddc61989c3c3ad5a0de7663c80939bc747ff349842e07443d550185"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0d9dfc7b9447129b6040be9656d4c50f1dbe4d17c87448e0565c90b5b61fc9e0"
    sha256 cellar: :any_skip_relocation, ventura:       "7c153fb993d37b2911d4d7c22b5e2b8d573bb02b31353dd527b57b9f8732b094"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e336133102abc7475f3a071b02b1bb2acffd0785476ba066fc6d86c41ad7200d"
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
