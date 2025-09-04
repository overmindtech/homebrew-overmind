class OvermindCli < Formula
  desc "CLI to interact with the Overmind API"
  homepage "https://overmind.tech/"
  url "https://github.com/overmindtech/cli/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "1908cac326c300dd710afcebd92cfaf7daf7778b281d96d61fadea22108b66c9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/overmindtech/overmind"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b76de23f4e3c44263dd43e393aeedba40a1822adcbf04dfd907b5535a52a536d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ca10d03524f2d9dff638c2670f899095801a74b84f326abb7d5ad836fb92fed5"
    sha256 cellar: :any_skip_relocation, ventura:       "c307eb8e054aca34d38cc655dc4a4a2d569c629423ff144317ae92381ca760ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a149caaed633e928e1390852336e9f744ec047f57425d2ee7755f6b1340fc152"
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
