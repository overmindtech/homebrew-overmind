class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.26.5.tar.gz"
  sha256 "471a4ed49373c9a970ef59925d20c0cfb7a13de5d89c9579a04eacb4d7ee7022"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3c43d267d9fb5a78d38fff056650f834cbf9122b1bafc915faf47f2d9b58de15"
    sha256 cellar: :any_skip_relocation, ventura:      "7a9b2eeb5b1e42560df3703a753ba76f562420ce4574daa86b298c7190c7e56f"
    sha256 cellar: :any_skip_relocation, monterey:     "74bec3ceefe15f633a30d7a6e311052b99d3f30ea0ebf7a399881f8d365d30a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c1b94251cab351b14f13d234b7d3322468127405d066497618c14261d5bd2479"
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
