class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.29.4.tar.gz"
  sha256 "c6935f9ae3e6828ac5d490e1a109017ca37f67b72abed722ce4311bc8df112ee"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6a0e569fe80c78ad7223fd40073c39aec76cb61c33edd2f14b4eaf8e93381800"
    sha256 cellar: :any_skip_relocation, ventura:      "57f6be4a7014768cb01d3cb029d740ccb6d144d4c70325d94d883d5a44b5359b"
    sha256 cellar: :any_skip_relocation, monterey:     "6fe920cd8d460766e7ab3ff06f8be212780490c66067320ec9272c47aa2f2d3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1636362e70c2ac11bf30e00d268fc6988c89f3c2e1e7c7eb287c5acc35d7e9a2"
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
