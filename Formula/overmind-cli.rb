class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.9.4.tar.gz"
  sha256 "387074392d7e55dd521d10c7289bfea0b1cd5868fb12b08bfc23a18384537ca3"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5996761abb899b0e7dd482b86faafedea1f03d34969b35578f6d6644de0a3f3e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5ccec2c35d6035ace34ec2865d9d62072b655fb8df275655ef3fac902cb7cad6"
    sha256 cellar: :any_skip_relocation, ventura:       "5e0ac7807c2545a48a190af809b085bf989f3ddfb6f1013b9467cbb84b06f9d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ca01763f206c2f4bc15bc42a3c33ce9da0deeb27b4e1adbdcd339d62038e7dc3"
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
