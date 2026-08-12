class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.0.tar.gz"
  sha256 "a68f68e6e6aeff55c05536390db63ad7b2f0f872d2547213a494c18b5c1e8341"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "60a8fa12046c921148e5f8f653f865a2cff630871ef79ed68f0ec3d4ca654901"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5e3d22e7c1a37d42d63e92ecf4bf0f79091f3f8b3125a82fe8553f71f6ef7b8f"
    sha256 cellar: :any,                 x86_64_linux:  "46e605997addf278bb314f65e62ead16da3ff66a953990f807b3e32eecd3a88a"
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
