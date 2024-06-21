class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.8.tar.gz"
  sha256 "7eb8f6d650613d9b35bc4919fb604d295926a728fb58dc43d2d8b6bccdc0911e"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "432cc9303eb7f4db717f1ebc5e2ad30c93b46b86429380e708bfca1c6db24491"
    sha256 cellar: :any_skip_relocation, ventura:      "9dce19da5d58f6ba4e79d25f8ee2ae12b774db98275be7b87bf8c788e595b6bf"
    sha256 cellar: :any_skip_relocation, monterey:     "bf6c01efdd8b9546ac7b60636646e3d8d52f6f95620d1fcd7a22e3d4e17572dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bebc27840bded1174ab5b3baa470fa4ef6598f9fd8a1c4075704df4ae8b4a5c1"
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
