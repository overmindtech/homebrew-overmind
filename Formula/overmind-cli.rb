class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.18.5.tar.gz"
  sha256 "712c22f5da8b69421d5ffbf90276b7eee1d3811dd56395b686ffbcbdd0a7929a"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "01ba4761190f401913e37fa9a54a0e6c1b5cdb34ec43d022ef5701f911845c4d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4b298ddd3d4bfcccd91598e8fd1872cea4d74aa1d014242a0bd0e677128bad0c"
    sha256 cellar: :any,                 x86_64_linux:  "f6901df16e98d56f82087b9c141c2671962e064c5b65e7ec888c32b6778f96f7"
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
