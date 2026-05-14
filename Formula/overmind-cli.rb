class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.18.1.tar.gz"
  sha256 "e21199a137579a4742b4ef0f243fc6dec06fd5bdbe2bb711955ab55b068a121a"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0abf8352732b4ffd715f2eca1e71e64ea418ad9aa61db0c3df589099eb9e1a29"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f67bffd18949586a58f19a6838d935166eea63f547fc926f15ab368a61d4e2c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a8a029913e7f1633ee39b7458c722449999a230116ceccc35616ef8c35d541e"
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
