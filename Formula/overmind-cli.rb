class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.8.3.tar.gz"
  sha256 "6f6f223dac951e0fdc8bcbdb0a13c81cca2c8fd912682957bed13602888ec5f7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "711ea22f5e2f9bf78e47b9f1fc6dded41a1c58f111d905cbb3621dae7da262a7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "db10f12ebda7ec67bcb085f8c1c5ab8746a08661c1196847b5617aca42c18940"
    sha256 cellar: :any_skip_relocation, ventura:       "baa46688b6bc4db31bac95afc545df7a1ef321c0e2a8d91a52e5988ebad16936"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "56506ee2aab92f218f889339007eaa5565bc9bfb0c846669e232b6743fba1937"
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
