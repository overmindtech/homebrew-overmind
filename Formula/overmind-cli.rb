class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.16.4.tar.gz"
  sha256 "244a2fa3eb3acd159ceb57f70fe9286ef3bcbe05d7cf0ee3f362064c217cdf4e"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ca63a4d9d4a2c348a145a4f99ada726cbcf98436b56368cead736d2864262982"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ab158c6144ebdf9290ae38c903d4b1797e87ddac27cdb98b931574912146e064"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "16a8d57df9b92d479fc8b47b4790676f64d4ac89309b53ba68f2b08304f9c7de"
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
