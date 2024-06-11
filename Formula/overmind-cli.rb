class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.29.6.tar.gz"
  sha256 "9b08bb6065a669d3eb80ee1f5bc158b4a31a02876fcf2736db2d6a644bfed6dc"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "86f143af4da50677240dd48d0711a588ade7873b9d8b3c5d47a0d1f79b266ff0"
    sha256 cellar: :any_skip_relocation, ventura:      "b14a152a1cc98a39b9d2651c8093633b20ed6c593fa44ff9245bc88d59383299"
    sha256 cellar: :any_skip_relocation, monterey:     "788fa3394ca9389478ee08fe55d064d4439c58f2bd8d864832cec27393a3657d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aa1cce1065533b0dd187df7f4cc724cbb12d3d093f608564f9be889ff1d27cc2"
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
