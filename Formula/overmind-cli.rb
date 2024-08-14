class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "d2b2d9c303a2e0a8b2e1e4b4d5564e0abd04d5456a76f546da9e8a867b605e31"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8a5bc3d3e778f58ba00af7502ca024ffe67a7b1b8f94191134503cc0090c2c17"
    sha256 cellar: :any_skip_relocation, ventura:      "d03a981c605a325cc5bbaad0d602945f5219c2d4b9cedec609418b413fda12ef"
    sha256 cellar: :any_skip_relocation, monterey:     "31d8ca02ec1fa7cef5575187d58706599664f193ac2bb17c95ed1327cb0f43b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bfb65b54387eb54280ea247a09df63180df4065d11b5353efd2d21fdd2a01462"
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
