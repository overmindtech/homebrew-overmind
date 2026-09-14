class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.3.tar.gz"
  sha256 "87314d4644774d7e64d50a319c4dac0bb0aa5dab184f2797fd83364999e33b3b"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1572481e6496210a4d788fb3ef55adfe761730949349ee8ab95421c62fe3d71d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d5d8c90746060ebab9a4e131034b416c2c17c3e43e178cca7cfa1bc15f2b5934"
    sha256 cellar: :any,                 x86_64_linux:  "985472316df0ca358d67fcbcc7d33d7cc650d537926ba0bf1bb91b6c1b68bf09"
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
