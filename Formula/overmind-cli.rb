class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.17.0.tar.gz"
  sha256 "dc51c03ee03d1264d325fc7ba7f4ca9abccc3a5ff4bc60799c907719c4ea87ba"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7def632d1140808e0e9e69e1de91ffda30e2cb7edeb95f1fd61528e7374fc63d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "85fb01090797076b63411fc9fe2f5aefb5f344820fc66e432b9797f8ad198cfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "924d0709b5b27e0a22f7748e24dc1cf47b23d0148ce3b2e83bd45544fd2b22e2"
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
