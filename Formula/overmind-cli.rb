class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.5.1.tar.gz"
  sha256 "6ca9b22105d7ca3f5bb723589e960543fcd2fa6748a53e65450bcf4e3336eba3"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5b98f90ccb95b469f0b0ee128cbbfadb1a3a2bdafc3b48b02a822ae095d7d3f7"
    sha256 cellar: :any_skip_relocation, ventura:      "060909db0285091602dcfa027e06dfba0fda34edae5c99e4cc4e5f9f014b555f"
    sha256 cellar: :any_skip_relocation, monterey:     "16d83c5c799051a65307d541e2402de655e58b322fa3a0d4b38bb79f4fdc8db4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0b17280a6b568c8dfa9c378f0d1ff7e999e9d83507bd9fcd51826b4913d86eaf"
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
