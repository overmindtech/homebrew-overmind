class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "df2b0f9855bf504a75f65243474d8efe30dbbec12998470b50d5052c94a9e752"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a6888fc22d11779f57eb51765cf49e557a23ce98fd3255cbcae240498f26efbb"
    sha256 cellar: :any_skip_relocation, ventura:      "359455cf29e4e75077f2db6f15570cf219e34587f428aff5161779c4b65fba97"
    sha256 cellar: :any_skip_relocation, monterey:     "c357ebc02e9710980222e6f21ea808f72615e6b3226650710a179a31dc8ac270"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "03aa545d921c52fb711162b1ed15d4d07eedce3765a7c6242ea342320bd35b50"
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
