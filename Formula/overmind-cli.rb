class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "7a6983aafdad526926c8be63bdb048c61e79979b5e661455723e6856db8cc379"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "45aa3bb96d1bc428a640f54449eae53f0c1a46eac38739eef3f492ebc4ef7265"
    sha256 cellar: :any_skip_relocation, ventura:      "f65d4efa7404edd1e02724ddfbc6d102cbb189af0a9c29d642f8994b04c9d97a"
    sha256 cellar: :any_skip_relocation, monterey:     "646131336dcc891f6e20f8c06c5942ca01b84cce12646c89da70e6b76f6dbd05"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b2881dd668e87e7ff0719117e1d579ea01c688c88fee26d1e075bf47aea6caac"
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
