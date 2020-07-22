class Pumba < Formula
  desc "Chaos testing tool for Docker"
  homepage "https://github.com/alexei-led/pumba"
  url "https://github.com/alexei-led/pumba/archive/0.7.4.tar.gz"
  sha256 "319a5ec5538022a2cdb8065c489272af474fcbc3f55d194df085b4cf90e22bbe"
  license "Apache-2.0"
  head "https://github.com/alexei-led/pumba.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1125e8ddb43443e025e01f151de6989df2cda91e2185820e785329a0eb6c8bde" => :catalina
    sha256 "b44858bb0ecb84dc2318d8ead146dd3ae3db36568ec9eacf1c049e24300b85bb" => :mojave
    sha256 "96f9bc0b4ad4dc2b505a30d3b9c05c40682fa3332d5c2becd2885e907296ac7d" => :high_sierra
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w -X main.Version=#{version}",
           "-trimpath", "-o", bin/"pumba", "./cmd"
    prefix.install_metafiles
  end

  test do
    output = pipe_output("#{bin}/pumba rm test-container 2>&1")
    assert_match "Is the docker daemon running?", output
  end
end
