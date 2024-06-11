class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.29.6.tar.gz"
  sha256 "9b08bb6065a669d3eb80ee1f5bc158b4a31a02876fcf2736db2d6a644bfed6dc"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "fbfc6c8bc1fd6edb36d3fdecc2568e08e55faf5c6645dc5b17b8370c9ad2a7d0"
    sha256 cellar: :any_skip_relocation, ventura:      "1782cfc775857a42026e00ecf1bc7d6cd6c6e760f9f32abf37857253e375066e"
    sha256 cellar: :any_skip_relocation, monterey:     "e076eaeea7f29ad9344985a2cc87b9389d7ee1e9926f1c34c07890e0803665aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9ff8ff738fa3b0469068c651f0b5c44bb51bcf9baaf16837ffb315cd8de0eac9"
  end

  depends_on "go" => :build

  def install
    # Write the version of the package to a file so that it can be compiled into
    # the binary
    File.write("tracing/commit.txt", "v#{version}-brew")
    File.write("cmd/commit.txt", "v#{version}-brew")

    system "go", "build", *std_go_args(ldflags: "-s -w", output: "overmind")

    bin.install "overmind"
  end

  test do
    system "#{bin}/overmind", "--version"
  end
end
