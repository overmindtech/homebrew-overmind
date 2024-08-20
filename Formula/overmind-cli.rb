class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "a858e6c9ac374302db8ff38f158bafe941e947193efecc089d665084436cf15b"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "7931b61ed64685a8ad18d2add379db069e03a41c77c2e9c21f18bd5fc494892b"
    sha256 cellar: :any_skip_relocation, ventura:      "f1618badeaf9aca7ff5bc1c32f762dcedcb9b8a6d91751aa6f0445ed8b3be23f"
    sha256 cellar: :any_skip_relocation, monterey:     "636b63c2824243e69de57ce58034623728f00a80811fe03c318c78e13730fb30"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a8985314f345cbe4e71ac76c2320c6cf18075611c207080a9fecb2e3e4b9b6d5"
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
