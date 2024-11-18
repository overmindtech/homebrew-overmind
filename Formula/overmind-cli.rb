class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.5.5.tar.gz"
  sha256 "3818143c06583adfbb00e1c5948594bca79b6d7f86322dc774e5577a14437e9f"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "084eead38a008114d43846fbbce04498b13e04217d877912aa0a4053373f9c6c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "91439d25e26b0f5ccfed0c1302e9277def69f5557b0b7804dc8fcce7926be3be"
    sha256 cellar: :any_skip_relocation, ventura:       "bf738ef6cc57bd994fa9ccb47ccda88802ba145a189acbe7dec84626e9ad3964"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c09c9d0199e6ec612941ba6eb839b673838ac6368ff5be5ebc56784f6aa2cd1"
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
