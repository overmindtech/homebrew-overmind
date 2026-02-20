class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.15.1.tar.gz"
  sha256 "68a421f31f2df9e2c01b4327fcb3623b8651c0f6715925efda8278428ce95e31"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "22e0ec26d4967919b4e45044e61ce7292fe9f1bfb77f75fc16e2195f050ed95a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "379d1a4b66ae8a592a5b430dbe2726b107a0207884d99af659889cf574377723"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8fc54758b9e26ff9a3d453e5af20ac8a72302a756e146e6f358f88c095d6edf4"
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
