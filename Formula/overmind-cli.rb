class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.12.0.tar.gz"
  sha256 "a112351dad730d1cb705b8247052038a4d2ee4a0d08402f206891846e1d81911"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4221a39b2259d1345c826e7cd6a2bac6bb376e8ee719e4696121b5d82d0c995b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5cb27e1c0489c06ad6878990bbadd959993104523d8955688e7ba0dd4035e202"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4d1dd23f0813b508ed20a071d9dd696c2807fcc36d5cfea8e2da0e020010c554"
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
