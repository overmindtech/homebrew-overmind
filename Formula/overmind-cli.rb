class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.8.3.tar.gz"
  sha256 "6f6f223dac951e0fdc8bcbdb0a13c81cca2c8fd912682957bed13602888ec5f7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "32ef431560a2e62d88bbaa4ab413911afc8ee696a25ce364c5a4480f60e3e2f4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "574f38898fb771774412398b06ecee83d1748c841b645de7050215815e437a66"
    sha256 cellar: :any_skip_relocation, ventura:       "8d38dd7048171f6afdefa27ba43ef521b552fe35e7f9db823cdc16b0aadd14a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1f17a6ff6bfd72d3d00e6590a8ca968bbd8fdfad6599aeeec5f447b6076a3f8c"
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
