class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.5.4.tar.gz"
  sha256 "4d0d41a521d53cee3dd1eef1c48c43022aa330bfd289b3d332c93de851cc8104"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d6e1b9e28492ebd4d9676adbeb8d2135b8f591bcfc17da4a860c13d23b049ecb"
    sha256 cellar: :any_skip_relocation, ventura:      "f0518d1e224c1d3f19c367fa25d5f23fbcddd157f6fdf4d4f69b81bc28ac0637"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "23d2165c7995e56c87451481bd6f5533f6f8fa836601d1b40235b3a3cb423322"
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
