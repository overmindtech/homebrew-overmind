class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.9.1.tar.gz"
  sha256 "0549e1bc9be9488f5485b4d5d9a06e84cb8b7753ae84ea521268a48d3381fce7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "675f5aa3657e7f3b44e1955ec65532e7c10c5cb494e07119d0d622080b191b60"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "834d116b1642eca2ce20a21208df81325676d80f284aef3366ab2c4a7e330cf8"
    sha256 cellar: :any_skip_relocation, ventura:       "55f0e2d919716d5435f1e4ebd4cd8ef4d8e4326154c1600a33ee224b5cadd1a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "942b8082641286fb68fec9f77c2460ca318e8e0795656b6d91470ef863c88be0"
  end

  depends_on "go" => :build

  def install
    # Compile the correct version into the binary
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/overmindtech/cli/tracing.version=v#{version}-brew", output: "overmind")

    bin.install "overmind"
  end

  test do
    system "#{bin}/overmind", "--version"
  end
end
