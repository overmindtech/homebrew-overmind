class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.29.2.tar.gz"
  sha256 "98b80e8e850ffd0bc3f63578ebfafa7398f85bc4b215f288dcc100b616b89613"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f957588acccb73e21097a664f8b3cc9c96b7ac45212a8b27cb1bffc24b68f01e"
    sha256 cellar: :any_skip_relocation, ventura:      "f78be0de52b7b77132dd4f1bdd1371920f49d8d72971cce03ffa65f8c446f7f0"
    sha256 cellar: :any_skip_relocation, monterey:     "47cd1178933e5cf9e3b2ccdb73e58ad90c99f5fe806ea475a15a9ec094666a0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "66eb270098be5bbb9926da895eadb286917a4c5116177b14aaf687084fc24c4d"
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
