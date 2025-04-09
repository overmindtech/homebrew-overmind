class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.7.9.tar.gz"
  sha256 "7b206d535c72825b84c218eb45cdf9f47ef0e56d4960479a1ec6ce11e5bc2a4a"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "26902c2c50ad39dd38be87abef5b74a12e76c49035e87de42d7ad1b2fdc6fb65"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a1d4970d1607280e0b9636f1485e3d7302c5ca8d0110c6107637e818bfeb9d10"
    sha256 cellar: :any_skip_relocation, ventura:       "f17f651a2996778aef8c5db0cf17e7a23ac443d0ca8243652edec3f8d63580b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0a210337dfaf2c837f6cceb2d869ce6f90a717e385ce8e073e98489e25c29d5d"
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
