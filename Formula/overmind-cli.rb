class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.0.10.tar.gz"
  sha256 "ae475703f73fb97ffa0a6e6461d653a5b631009f80019b3920e6b2ffd77de615"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4ecf3faf9528815c13d5c443efd3dd561a587ef6350571e6a023389a496df19a"
    sha256 cellar: :any_skip_relocation, ventura:      "a23e2e775a2adb5ddc63543ee9ed6ea5924effbab0c625cd0178660fb432d18d"
    sha256 cellar: :any_skip_relocation, monterey:     "a2764716defce9d0db195588337abf4be4db215805855a6f941139539145dc7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6178d66ba0e5dee038276472ad9c9b79fdd151c54330fe9f873c4a4e714e6f8c"
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
