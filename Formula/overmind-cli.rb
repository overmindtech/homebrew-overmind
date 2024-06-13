class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "0923fce41fec48ce990b4a279ec6ca9acaea60fa027ca914297a7ab98bbf3321"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f6972560e7acd3567e7cac88217f516b27da65aafb7d27644cb016d09dd2cf55"
    sha256 cellar: :any_skip_relocation, ventura:      "ce033158f000a1b5718af675a452e2582f187b255dea5713887ae3a80551aaea"
    sha256 cellar: :any_skip_relocation, monterey:     "e89ef3550d442340f4fc85d160cff5ba987a0db33ce45d4540d8ab40e97e04e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0f5345a8bc6cdfb3427d4c6b0293210861d114eb9874dcd50a62d2657f522b7b"
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
