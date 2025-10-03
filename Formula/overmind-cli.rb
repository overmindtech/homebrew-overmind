class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.9.5.tar.gz"
  sha256 "cce6ec1c0e2e72483993b923cbfba51155c361652dff368bf43ec0bc4180030e"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a7a7b71b1a9f60f51f75fbc2974a012878529e2e7b5f41433e14f2aa0e0966c1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1d4df622f933f8826fd8d3efef0f189f3fc84452d25440821df1e559d8c068a8"
    sha256 cellar: :any_skip_relocation, ventura:       "a1ca73b07772f859c3377b792f21f9386f281f9c7955a77d3250102c723b6b37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "920a4461a86f44f1ceb33f280d5b73c9f2d19da3ab7748d45bbf7a59040598b9"
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
