class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.9.2.tar.gz"
  sha256 "a1f3d0cb1bc63878fc3b94233282ed4279d4b51acf16efb77678892edefcd7d9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fef8f373a607e2181059d8049dd33608eac440c56557135f2b8940d675da0dca"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "acf7f22e45d8e8cb1b3e8f8a4019b1f6308b7d651b87b91408b21a0ce751e9e2"
    sha256 cellar: :any_skip_relocation, ventura:       "ffa69ef15727f34424f75778b4047652d6d33b1547b78208119be29da2fbab95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e61a2dd0510fc44bf530e8455042d83b67b8b43dc03427bd57eb695119871232"
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
