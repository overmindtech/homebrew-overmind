class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.27.0.tar.gz"
  sha256 "93040e78bcf030909afe4eedb8be7884717299b6798d4610053f66eabe6e8607"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "28e5151531ccceaad64ce21260af5f3a5b16af8a3323bd9a5a95be04999d6900"
    sha256 cellar: :any_skip_relocation, ventura:      "90f6c9367175ec17ffa7d552913867ffec9d0c54fee766b2bd947d8d5437e91f"
    sha256 cellar: :any_skip_relocation, monterey:     "0122f447e51e3d36df82b5645d69d9ab3cc03259ca732a397538e4e6ed18006d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c1b2e2af9fe5ca0fe5642125099e91c88bbc6f1a96a8fb5aaee452932b5c2954"
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
