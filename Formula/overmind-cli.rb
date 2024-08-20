class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "a858e6c9ac374302db8ff38f158bafe941e947193efecc089d665084436cf15b"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6eda74032ef1a4088254f84b9c90372cc3cf5dc89c36f3b51ba802339ed91e3d"
    sha256 cellar: :any_skip_relocation, ventura:      "2b990ece7fbf1b24a75b1cfb0234d79b5277f031360581f45070b5161c47b848"
    sha256 cellar: :any_skip_relocation, monterey:     "233153d8325e24fc3e5ebed65791fffdf947fc52f655359bb84dbf0eb2b65eae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eacfc0b0cc883f8fd33dd61a9fc33dbcbf25cc2a8fde9f9c51f6f5bdd31598c2"
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
