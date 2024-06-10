class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v0.29.4.tar.gz"
  sha256 "c6935f9ae3e6828ac5d490e1a109017ca37f67b72abed722ce4311bc8df112ee"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f35d875f640719249f951ba3453084e2ec882da41a6a22f77e64b226534b191f"
    sha256 cellar: :any_skip_relocation, ventura:      "1143be613779e0c45ed38f7532f62b4438ba8404510a7501fdc1a580100c62e3"
    sha256 cellar: :any_skip_relocation, monterey:     "a66353803a93c83318a3faf734be718f5e4d6317664cab07d42f35656e0d8d11"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3c0a5c0270ee37ed60d335d91bb58b937a254612e51dae696a0dda8c82fecd43"
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
