class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.15.0.tar.gz"
  sha256 "6054c6cb29d7a6fdc19fce9be6b06f0abd04a57ea73243ed984feb26ad5d4903"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "70b85ee676d1b0b3ddf5ac90f349a0e20d646e64e16d9a4a46524e0acb9c1381"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2f4e2c3cc9e57a8e91d1ddaf01faa4c5a9bc2f164be093d301c21504a99320e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d39cb579ceec8660a740a239df7c17a7137849f502c8bc84463dddf22cc109fa"
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
