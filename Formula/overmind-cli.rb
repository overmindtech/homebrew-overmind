class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.17.8.tar.gz"
  sha256 "e1413412fefcc637772f5f102264a9bb15967f8fcd3fc6c43562f48f3890d3b5"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8fbfe9ff42649a9f305d9bf29b5045de6ea1c4fc825c3d42cc47913728210196"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "11b5550c5cea1fd0a92151a094efc472609a82ea5bf2bef8ccd02dedf6eb9754"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0fc456db9f11a91bf2dad7d9c64d7232379037a16d35efc567fd6d03dc3228d7"
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
