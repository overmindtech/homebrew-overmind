class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.18.7.tar.gz"
  sha256 "dbb4759c025b2b6c23d4faa96edc0c2f1c8f4e537e89c335ddef0fde11eada91"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "56e99728c7f123ea67e267902a803520c8127e23dc66239192406b2789e22a6a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "796e69d95afa95221f5f48f9b39e9940b0247d48941b3b42ed611288cb9e7f29"
    sha256 cellar: :any,                 x86_64_linux:  "6ef577272f8fd798b2e44a01f6f30f9799995a96376fd0a895e636a7426199e4"
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
