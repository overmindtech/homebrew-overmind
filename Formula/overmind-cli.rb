class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.17.1.tar.gz"
  sha256 "ea5a109193f85ed53aeaf559168867aee66b6dc5586df7f48d2e885cbfde90aa"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c01e0f603bed05d75359f374029868cb0ced26a002add706c8d6a22618c77949"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9c46eff407704339c439a100ae2caad0c34d3c942a260e41eb6f87c0bf421962"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22758428036ac03a9212c48312696f2175ee426e81aa1e14cfbde676caabe10c"
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
