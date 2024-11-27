class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "de0850e45a4132597f3173a34409e081db73527d8df8c7bf701fe2bb5782b823"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6f4710deb66cae3f711a27e4661a5b961ba9b9e691e76d6a232d823f9f5a4cf6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7ce70e101ce452aa41e46dcee4cd5968f5bd5b9e52f3ada6141aa24f73a60f63"
    sha256 cellar: :any_skip_relocation, ventura:       "b5ebec08bbac1682ae8077bd9ddf4ecb629180d4521e9cfee796fb520e992640"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6b593d42174c5736d0c188d4be8a17c3bb8408e40932f827f53e83962df6647e"
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
