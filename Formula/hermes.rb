class Hermes < Formula
  desc "SNOMED CT terminology server, library and tools"
  homepage "https://github.com/wardle/hermes"
  url "https://github.com/wardle/hermes/releases/download/v1.4.1580/hermes-1.4.1580-lucene10.jar"
  version "1.4.1580"
  sha256 "e858a4925c48645dccc03484c126bc95252e07032d83b57f1f0729361f3c9a08"
  license "EPL-2.0"

  depends_on "openjdk"

  def install
    libexec.install "hermes-#{version}-lucene10.jar" => "hermes.jar"
    (bin/"hermes").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk"].opt_bin}/java" \
        --enable-native-access=ALL-UNNAMED \
        --sun-misc-unsafe-memory-access=allow \
        -jar "#{libexec}/hermes.jar" "$@"
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/hermes --help")
  end
end
