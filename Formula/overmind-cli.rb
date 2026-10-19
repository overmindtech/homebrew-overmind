class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.5.tar.gz"
  sha256 "c4d3dccbec5fe8f7d9af950bd1bae9a7797328ceb39ba3acba0f0438c0f9181c"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1d80eb7104d7cc72de6cc62ef8981ee88c62905dde8dd7a153a1dae22da1dbeb"
    sha256 cellar: :any,                 x86_64_linux:  "7ec608b74edb1c799aa808bb4fe1d2daf866d362b8424756a1743036df3ed2c9"
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
