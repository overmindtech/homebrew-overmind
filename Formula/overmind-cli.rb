class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.29.1.tar.gz"
  sha256 "e7213914047a6d40fb0c0a7325a56b3a93be04b8432692eb453a3a07191a34e6"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "bad2c94c5d43f4e4bf9ec22f3b4cff3d8dd24951f9e67b597aa99554638b295a"
    sha256 cellar: :any_skip_relocation, ventura:      "23ee7a13974c62adae13ea22d77bff33bcd4311fecf7b18b5df400f9c7604e50"
    sha256 cellar: :any_skip_relocation, monterey:     "723fb53a1c82f1e17aefbf37b24e6fb17bdf13040844c383d34d95c3941ee84d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9309df28bb9128b828644b43706a8ad8b8691a9362689c36d6dba1693d179223"
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
