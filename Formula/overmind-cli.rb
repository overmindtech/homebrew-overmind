class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "df2b0f9855bf504a75f65243474d8efe30dbbec12998470b50d5052c94a9e752"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "895d9b627d11cf04874e643065ac3862c37e811cf8f1bb2ad0f2b9aa4f893cee"
    sha256 cellar: :any_skip_relocation, ventura:      "d868f9b3c7524920f32053277dcb0a6b2139ea5d9bcdff8dda6698842d1c94f4"
    sha256 cellar: :any_skip_relocation, monterey:     "ebd4fafb16760896b942af760ca9f19b4a3fbb2baf595311a622da1f7c70b9e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8191dd88864665db38689bd532b8298080fc159bc63d9c0dcf7034cfa03d7332"
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
