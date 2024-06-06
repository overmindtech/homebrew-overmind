class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.29.1.tar.gz"
  sha256 "e7213914047a6d40fb0c0a7325a56b3a93be04b8432692eb453a3a07191a34e6"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "209d7cdb95691fc4b60f9ee03169a18d1f10e517d7b4abf781190c08ebe0150e"
    sha256 cellar: :any_skip_relocation, ventura:      "6feecd41e4c4078909078bc003ab8bdd33f4ec008e9c0a605b6300c39b3c3cb8"
    sha256 cellar: :any_skip_relocation, monterey:     "bd38018ca0af62fae7d55e28aa626b5792da17d910cfcc6e20ab5477545d1c8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4b1c96578a2ea3c80cc410c94c7079684c0a9fe49100f4f8ca499cd0dc1892a2"
  end

  depends_on "go" => :build

  def install
    # Write the version of the package to a file so that it can be compiled into
    # the binary
    File.write("tracing/commit.txt", "v#{version}-brew")
    File.write("cmd/commit.txt", "v#{version}-brew")

    system "go", "build", *std_go_args(ldflags: "-s -w", output: "overmind")

    bin.install "overmind"
  end

  test do
    system "#{bin}/overmind", "--version"
  end
end
