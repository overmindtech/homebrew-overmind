class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.28.1.tar.gz"
  sha256 "9b6ca828d342981f88abe6587c98d0e1925a286d28f95a72d515037101815df0"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "27541aaeb41f1ed4b670674f35f543e15bdd931f511ed5e20dd0962d14ffec6d"
    sha256 cellar: :any_skip_relocation, ventura:      "ba466d781ce2322eace4d4304faeed97b93e6546db2515f487ecca518a94db60"
    sha256 cellar: :any_skip_relocation, monterey:     "286ebf67bb366c1cdcddbdc55e32a96ed4399254f0504f8b3041bb1e4d848f8d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d68f8fa33f06f1b8199ab36034506b11525edefa57922beeb22bc5234b249e07"
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
