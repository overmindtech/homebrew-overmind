class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "137d1c8f2add46450bfb82e9b9395e29ac89c719b90baae58f0ab3b5ecb02dd8"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "357daeaa1011b3a2041d9267e8c397bac02977baa75cd6cde36147b4d73ced96"
    sha256 cellar: :any_skip_relocation, ventura:      "a7003b6bf281b5ae06d9762de4ecdfa520eb1b9f015f5eccb71e37c46bc96a31"
    sha256 cellar: :any_skip_relocation, monterey:     "dea0e66404ff0cfbe50212b43a1389ee10800ea27c1653876e5a9fa28ad694ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "42cc1c1c11b522630a1fa671d00ae68efe99835a5c196137c6f10c6e30fef641"
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
