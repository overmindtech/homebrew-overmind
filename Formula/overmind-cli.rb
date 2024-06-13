class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "0923fce41fec48ce990b4a279ec6ca9acaea60fa027ca914297a7ab98bbf3321"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f2f02000a4a1ea46910175a551b3211282e3fa5c405c1694ac9a5222a907508c"
    sha256 cellar: :any_skip_relocation, ventura:      "61243562f2f090dc4e919820d96db7a822f65c9eb9343fe3be8688616673997e"
    sha256 cellar: :any_skip_relocation, monterey:     "06ce81345a63c64fec729d88129d241f49cc8b62722fd1432b4e07d3f0960c15"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7b4eea7907285a4df8342ab8d6c6a92cba2053e54d3207719b6284526d1beb1d"
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
