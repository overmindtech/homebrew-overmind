class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.8.1.tar.gz"
  sha256 "6ef1727b863913942f2c0f028303764a74c60ca9333ecb8ac1f53e9ef33543d6"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "11d80d69b1a403dcebf78ee1519f2a23a5360acc62228e57c3aef5b0524e9b6b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "620c471eb9bd5e967f79e24c1b03ba831f27dfd36164707934302498e7ca10e1"
    sha256 cellar: :any_skip_relocation, ventura:       "abdef5a57b46c76c095ef1a174b378cbea66c00a668c68db04c7dd57e9b365b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba2f1d07d8b21468983f0a76fad7458ac29215a317c809bfc1b792c7bd1d082f"
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
