class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.25.17.tar.gz"
  sha256 "a366ceca8e810325bff8de213cb7f448b24b56954482bda1bd4c5ab36811c625"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5d3bf8e3916232633229fe5cbc906476fc11e970ede0bcabc89e39eea595884a"
    sha256 cellar: :any_skip_relocation, ventura:      "25338191f31e4e828e39e105291f2aeeaf240542e89f9ea5e200f00fb2f43c5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6ec3168f5b67e27e31eaee5a2ccf86811a4384a57a731af8eace34007e1cd0d6"
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
