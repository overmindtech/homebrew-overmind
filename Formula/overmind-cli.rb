class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "a79af2964de444733662ad3f01a8c735d8409ad5ea6b5e3ba7e94513b43cde15"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e0c528827e622110e749587819e8212d0fdc63133c43ddbc894d2c5bcaa349b3"
    sha256 cellar: :any_skip_relocation, ventura:      "cf361a543deff1b4dca84ddc93799523c9512ab8f47e67b924a9e724fd86d493"
    sha256 cellar: :any_skip_relocation, monterey:     "eb9c497b586393d5393f8f8226a8dbbda4bd8b8d64dd875d868e71c9f37d0487"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4796527c55bb59714b342e58acf65710ca2925b7c3fb2c91825689406c577af2"
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
