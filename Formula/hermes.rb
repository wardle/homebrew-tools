class Hermes < Formula
  desc "SNOMED CT terminology server, library and tools"
  homepage "https://github.com/wardle/hermes"
  url "https://github.com/wardle/hermes/releases/download/v1.4.1575/hermes-1.4.1575-lucene10.jar"
  version "1.4.1575"
  sha256 "c3d5b760dccbf40f57a190d9a300b587121cd1b8b1cc2a0277ca86b9b09e859c"
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
