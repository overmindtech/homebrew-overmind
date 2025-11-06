class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "bc593fc6d4a5acb129afe2e6f37956c8aac8655c26f2e99d1f6c176d9e1e6d78"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "669d2506c60ecdc8447d17948e12d3739a5e26e8daf3bf67b0a784395134305d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8b27dfd959ebb7bbe212f86a20370ccc484fb360e5366c1799adc3e332af6edb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2c5aa4cb0e6233b61e6edf30348de8fcbbf2914b0e96c21ae01f992331783048"
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
