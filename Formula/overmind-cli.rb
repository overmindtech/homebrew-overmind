class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.3.tar.gz"
  sha256 "87314d4644774d7e64d50a319c4dac0bb0aa5dab184f2797fd83364999e33b3b"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "83cd64723eab150bdc44f509558a2ba222eabb420ec31705517059b79f3a1e7e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d547f1470959e452e325d368b0acd7e3cce1ada91f5894fe38bd7e69fb773f67"
    sha256 cellar: :any,                 x86_64_linux:  "d9d8d8221463dcd3e3ad75cb6e549862ce10e56b2fe6530c2cd0a627c7b85d05"
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
