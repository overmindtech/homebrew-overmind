class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.7.6.tar.gz"
  sha256 "7ebfcce56c155d838929ef6224d0a942606edf6153d042beaa50e4147aafc380"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2fba9fcfc198c019e41a9eff43976f9a7a6d8b6a195784644a5184bfbdaa0866"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e8d0e150d97051abdf22b716951a084c035cac5fe98004349dc658f0cadf67c3"
    sha256 cellar: :any_skip_relocation, ventura:       "da6a78a998d223a6c2ee8c45ea247f8a4ec5c3f8ae730cc0cf95dc814f52d12e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7732f18aeecf0d4ca0d0ef388bcdcca54aa13e1d29c56397cc4bac4d80682f2"
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
