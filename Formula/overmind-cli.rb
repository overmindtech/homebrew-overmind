class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.29.9.tar.gz"
  sha256 "e4898ecefad633e4205ae1d0fc71fd3b19cae1b4a2d9b11dba0ff75af27257aa"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e41d0892a9719ca3064f0e7c6f6b1248734b16ceefbde4c27d93c323210ca5bd"
    sha256 cellar: :any_skip_relocation, ventura:      "e6e52170a8c54c82d989a4308d54fa0fa7bcde3391d9a636a332df2521b445b9"
    sha256 cellar: :any_skip_relocation, monterey:     "48c26c0afdfff363668fbb730fff144c02d4cf742ce024f64ea4fd4656b0a996"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fac1ead91884281b6a04197c584258301b37966ac4a655afe04961003bcf3a6a"
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
