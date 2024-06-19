class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "137d1c8f2add46450bfb82e9b9395e29ac89c719b90baae58f0ab3b5ecb02dd8"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "56d26b5921839230d745f507a3baa0f70089ba638292913f5d6df871d57a3c79"
    sha256 cellar: :any_skip_relocation, ventura:      "023e2d771f7c2ec3dc94e3853a28d938244996528ebb27e0b399830288282fbb"
    sha256 cellar: :any_skip_relocation, monterey:     "2fa6bb3acfca14d061dbcb9b3e73aa01023f64f62f3a237277fe2f39b5c35059"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9fa91a84879443f814ed785e872e09ae9224b5c416f9cb2b8d7e013d748b36d9"
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
