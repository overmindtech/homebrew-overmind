class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.6.tar.gz"
  sha256 "63926a563b0ea072809f9d4bb57229643cccbe0c422218f87743c784fbda6da6"
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
