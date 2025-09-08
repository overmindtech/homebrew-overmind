class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.9.1.tar.gz"
  sha256 "0549e1bc9be9488f5485b4d5d9a06e84cb8b7753ae84ea521268a48d3381fce7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ba30edef739e3dafb042a6d90f10ae14060f9fac903d6b1df81b8fcebf09b3ed"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0d38fcdc13e124c834ae9ad2498697db969037f97a9ca8f88b2fbf312e30ff99"
    sha256 cellar: :any_skip_relocation, ventura:       "dd5d5f666f377ef26d82e5b476e499531e888ce3036d0865aaab995f17794c4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1e95a6fc168608bb9a80e86054e51f0c7984ad2b653a6a950470e7a76a499e1d"
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
