class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.28.0.tar.gz"
  sha256 "2cbc8d693a25fe30ed4701fd4da2521897bcf06c89096c79e3354c1fbfbdfa3b"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3f79de87ae3b1b11e7cea11883d3bee808101227ab22896ebf4e9c196a352fb6"
    sha256 cellar: :any_skip_relocation, ventura:      "ba2b8b503effcec811bff4fd71a1ed3ae3e12f7c2ea4ea852b9bfc1dd1393b57"
    sha256 cellar: :any_skip_relocation, monterey:     "70b21c02c3b4e863e6435cf6a24e738f0cc63f382100a7ff44d54d3e4b3a771a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "403c7f3baa81b8b0dfb9ea1afda26174b245a63dfc222bc546431cb9a12349ff"
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
