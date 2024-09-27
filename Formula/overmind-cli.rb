class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.5.1.tar.gz"
  sha256 "6ca9b22105d7ca3f5bb723589e960543fcd2fa6748a53e65450bcf4e3336eba3"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "dbb0af32c829644c41363a7e062fb74d1d794e63dddc2ab0fc86e91268cdd1ad"
    sha256 cellar: :any_skip_relocation, ventura:      "17ef92275695e2383148b217c5fba5caabec07f970d3f85dc1c50dc7876f96e6"
    sha256 cellar: :any_skip_relocation, monterey:     "39ae136749462abb9f4b265b0d658d5e5cf72823d11d0f55705c7a3ab524b845"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eb7fa687bacf0853581aad88724273c8127cbdea40f9b4d0a03f2730c0dbcafc"
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
