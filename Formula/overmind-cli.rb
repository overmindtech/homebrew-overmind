class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "7eb1dcd3cc04c810aedb5f5abfed9f5b3b0b7fac9f7e630800d3fa51f3010fa0"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9969a4c72b0a012b945340dc90035f7b50b214a169dba837e6a530297b579731"
    sha256 cellar: :any_skip_relocation, ventura:      "72e33ec9e6298938cc49340197cb6e38fbfc6f8e1883d202f7d11b3653d94962"
    sha256 cellar: :any_skip_relocation, monterey:     "8d386e986cdf930c73e7832e734854a6461dd866f86a6d24b877b3ebb0e7ea84"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0c7b5112b577a05d3dd6160e7aee6782a672698f50f51323af1994972cd2f013"
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
