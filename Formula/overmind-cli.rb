class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "7eb1dcd3cc04c810aedb5f5abfed9f5b3b0b7fac9f7e630800d3fa51f3010fa0"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "77b924dd547796447aad03b2f0e5d27b5f2f0674dc19a9c8bf4f449bf9189560"
    sha256 cellar: :any_skip_relocation, ventura:      "a333ae63666c0baa5eab5348ae9ba04c1ac64bd0bae9c8b031083fe47692e079"
    sha256 cellar: :any_skip_relocation, monterey:     "ceb2531a40a03055f91404f5ed57db344f8466c8c6a4690aeb0404ac9070cfb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "157035f4ea6e7c85ed82f0a9ab1476f35c8c9462a3cb027af8ad6d9dd32e822c"
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
