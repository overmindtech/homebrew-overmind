class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.26.7.tar.gz"
  sha256 "9eaacd609f8771fe9bf2f37f043c005e548954831f9e655bcfd96480ed7a5f56"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "741cea4a7d0c67653406d222bafdac8d860a4d0d5ae423a03d2c6d23d5a00160"
    sha256 cellar: :any_skip_relocation, ventura:      "c77134d1eb1ce7ba766c9457003b847df19e497a77a13f24b6642f9321c2dd15"
    sha256 cellar: :any_skip_relocation, monterey:     "8e0814ad41c1ff20d8fdce78307105a9bc8cb95b8ab1d5160d9da1e30a10cd08"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5aee9c273e055a268377326e40062bc44f292359091afa3fde11b3e4911b8d41"
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
