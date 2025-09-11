class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.9.4.tar.gz"
  sha256 "387074392d7e55dd521d10c7289bfea0b1cd5868fb12b08bfc23a18384537ca3"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e3b36fad539daf2910c2e6693701bae05922f3139fd132edacf0009707b6b768"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6f789e99718c099f938518db03a14da5f30c3bffb32be6e134dd494af96d13e8"
    sha256 cellar: :any_skip_relocation, ventura:       "a23952f757b7a5d702895d2c594957381be0fd0a844d816333d0a2208fba9035"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "868ab28d7af9464d50d3927e9fcc813d45c293691b2c1bf6842676af139b1a8c"
  end

  depends_on "go" => :build

  def install
    # Compile the correct version into the binary
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/overmindtech/cli/tracing.version=v#{version}-brew", output: "overmind")

    bin.install "overmind"
  end

  test do
    system "#{bin}/overmind", "--version"
  end
end
