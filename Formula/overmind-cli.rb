class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "d1d264bc247e18056a2b40d647b34104428e3f80aa3ed7c0cd4f71a48fee1640"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "42d8074b61edbb293267dd3c4602ce6ca11c2fe9f352285d5ea76d9d6f3d641a"
    sha256 cellar: :any_skip_relocation, ventura:      "7a5276738b2b8c974b73bc3c1118c334236c0608da891c00af40181675bdfcff"
    sha256 cellar: :any_skip_relocation, monterey:     "345a6c5ad56b9f7ca5ff8e52d594c21b9782926959eca8cf683d5fd2ff998e87"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "10bd52865dd35675e4c947905cf7e8aeea5d7bb19c0f8aa0d95f92dbeb152c5a"
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
