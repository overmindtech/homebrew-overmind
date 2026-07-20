class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.18.8.tar.gz"
  sha256 "b0b9e0dfe3daa874e81392b8ae76ed900c9d941e0de3e2302937773060282499"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4b60c3e97d35f85d4b23b9072e43c1cd9032471eb87a5e2ffaf34f971c45899d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1f65cdea62dac0f4d64b3fdd1bfdeb0256241c896b1d10dcdb8fb05827a16e7c"
    sha256 cellar: :any,                 x86_64_linux:  "f5d5d205143e18c69235742925ec94c545b3acc3077ba8abd27345be8f6b5266"
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
