class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.4.tar.gz"
  sha256 "57889778a38d89734b780a6d843c78a9bc8dfec3c3028866b8c320bf6f960b7a"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b488643231bb588dd307429899cb0b22b0e93510f50a49cdf9409eee411bdce2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "621f9e103755122b8f2cc514431ae3689e9b75a5f7f5546cea0a5d10e4e73af8"
    sha256 cellar: :any,                 x86_64_linux:  "c4be9cebd47185bef1943224c2773f3538018be8fce41f491afb979f7fa59705"
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
