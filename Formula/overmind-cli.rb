class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.8.tar.gz"
  sha256 "d2bd962f6dfe19a74bf70f114034c22f2fa4338e34c48bd2c909a11d514235ff"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "db646f549b32837bd1db9ccfd13867cdc0d87d220fe923f3693840affa52ebe1"
    sha256 cellar: :any,                 x86_64_linux:  "ec5b3267bc2d1ab193b73b6963219990b15987192f1a82483b5f8ad6d9ccc874"
  end

  depends_on "go" => :build

  def install
    # Compile the correct version into the binary
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/overmindtech/cli/tracing.version=v#{version}", output: "overmind")

    bin.install "overmind"
  end

  test do
    system "#{bin}/overmind", "--version"
  end
end
