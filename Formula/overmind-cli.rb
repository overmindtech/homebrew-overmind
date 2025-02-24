class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.7.1.tar.gz"
  sha256 "f353b87fd94b8bd55424971e0fa50e8fcf38c59720bd264ade31241403c936c3"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8bc3c37503a16ea7ea65929a0449716be434269c0f0d6bcbae66a36fc310333a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ace9f369558a965ad299ea433645f905a7c14010419484ffeecf21a484ff605f"
    sha256 cellar: :any_skip_relocation, ventura:       "f3049fa1ce6d8543a99fc18317aa6ea32f2a643643800a6f48ad0e408d76bba5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb1109eed12d1a62e93a23586d55700bbb1424d9b495c92b9c08f1a066eaeaaf"
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
