class Hermes < Formula
  desc "SNOMED CT terminology server, library and tools"
  homepage "https://github.com/wardle/hermes"
  url "https://github.com/wardle/hermes/releases/download/v1.4.1563/hermes-1.4.1563-lucene10.jar"
  version "1.4.1563"
  sha256 "26706d3e10a350c0f8eaadfb9494bde2eb8a62808fd971d1ba71f7bfa8656fff"
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
