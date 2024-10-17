class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.5.3.tar.gz"
  sha256 "a1d10e912a62cb734a072265b6ff2be00cbd408de05768d5bd6de7bc1bb48119"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "26ef4094256e28bd4110573862c7f22c26d955facdafb27a3456bcc96a71b847"
    sha256 cellar: :any_skip_relocation, ventura:      "075478414bbd06de8d11047b971d203c44614637e4ec8e90d3c063530b08807f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1e3309793a77dedd7c5acef75c5c9d0a37bd458506a2f2bf9cdb57b6260f1a44"
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
