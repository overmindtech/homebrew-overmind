class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.12.tar.gz"
  sha256 "72459d400332eeb71c0e749c8deb798e8ece2275ce997fb0c588ef3233b366d1"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "0a77eee6f3607e9215f9c808f5d2a0d6620e34dc17cf0c631e3f0ed615f7d807"
    sha256 cellar: :any_skip_relocation, ventura:      "a9188fce8005ced259dbdd5efda159f68c4f0e5161dc3f87868a5d849c094af1"
    sha256 cellar: :any_skip_relocation, monterey:     "7335603d67266cfd97ad24430b464215a9545250781909912a22f15da0c054f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c664ebecd12acbc278b783bd5774325859e6a9fb8de36c0b1e7e5544aff59fbf"
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
