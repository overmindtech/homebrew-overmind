class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.14.tar.gz"
  sha256 "804b1a14afa7e20d9e3de0fbe056c8db397207447f1651efe88b44de7eb5acd2"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c771857139c7cf8c71499a4e3dd9bbfc30770b392b40fbb392d71da7e2296e64"
    sha256 cellar: :any_skip_relocation, ventura:      "a1f702bec14e3e66bcf1078b31325e65fb65a7627fbc28ff3784bda031f5b2f9"
    sha256 cellar: :any_skip_relocation, monterey:     "ccd14dae31067b4a86730b4ad4703a88b7411851c78e005e06d258dc4bdefed8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c5fe3db63c14ba29782fbaa3bc02ee3862e0c64ff14ae0e8f0a032b587de7200"
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
