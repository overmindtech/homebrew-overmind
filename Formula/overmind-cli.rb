class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.17.2.tar.gz"
  sha256 "21b35d4bf0429ca6d50673759d63dce65a369e1177a6ba7152a20e89bde70c02"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3c1208052122793906aa23d8e3b041b9b4b873543ca40be7831ea943dc19a3ff"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f519d53fa7582e14f74d6965fa91d3374356781eb923b77bc401aff5a46e237b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "97aefc878458cd675be904994fd347e9077ac1027103320cd3b216df0a4634c7"
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
