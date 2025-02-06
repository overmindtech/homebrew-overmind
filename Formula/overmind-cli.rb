class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.6.1.tar.gz"
  sha256 "4a714e7118a4051a5ddf619055315b8675d6c95a9abeb597c474ca00b47952e7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "936ac865b6fa3e80290f6d8aef38d0c8fbb7fa9b7e29d3d7c7e6fddc410b756c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d2706c372eba9b90f29c1aec2c7f4c1cc66cf32388b3f10efb01cb51d2bb115e"
    sha256 cellar: :any_skip_relocation, ventura:       "110ad2fd0474cf98a0f10424d72e006a721345af614b3e1ccff4227782177353"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ca7309f668441a1f8744c966657dc51d7b4bd72f4287f1e17bca3505fdc4dd7"
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
