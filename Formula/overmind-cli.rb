class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.19.2.tar.gz"
  sha256 "7598b6330e51d03f7bde115e576f6582a35e372077d82470f50beb400e26c53a"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6938f11f10487530564e5a3355aed3cecfb667c479224e5c7f1a891da72449ad"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bcc51baee1fba7880ede6923223b4ec43fa604707fa3f5c13f603f7c42e4016f"
    sha256 cellar: :any,                 x86_64_linux:  "e7579e89a32b71dcd04a0e1841c82146517ad08e26daf76b09f343e687e475ef"
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
