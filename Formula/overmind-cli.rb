class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.5.5.tar.gz"
  sha256 "3818143c06583adfbb00e1c5948594bca79b6d7f86322dc774e5577a14437e9f"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "780a584e17fc1a7824fad22658a43f621a410156358321f6d4629c93e16016bb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e9e8e7f44c19af9a9f418c6e4cf231ef6517bf86d705e046f5d860436d711709"
    sha256 cellar: :any_skip_relocation, ventura:       "c1ae4c69a77334cc6b0e656c510572c80d226a89d91325d6ef514210201fb20a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f00e7e077fb570477ff77669700c6fe8502062c046793fa1b20b2d4d5b9fe9e4"
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
