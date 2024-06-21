class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.8.tar.gz"
  sha256 "7eb8f6d650613d9b35bc4919fb604d295926a728fb58dc43d2d8b6bccdc0911e"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "7e1b5b68dc94b32ee8d3197fdf9627fd45a978cec757b7f40e315d94ab4f23c5"
    sha256 cellar: :any_skip_relocation, ventura:      "2ee54ed57c7cb5574de607a383e07109957f656b9fff9fd298111ef828871058"
    sha256 cellar: :any_skip_relocation, monterey:     "386eb14eaaaef972c983083e34e0efa0ce42a67c301cbaab44fe8507d8afcaa2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2d2f03bae5ed98ffca8b2846c788178947689cd33dd3617ee2fc45c47192a330"
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
