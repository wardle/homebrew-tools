class Hermes < Formula
  desc "SNOMED CT terminology server, library and tools"
  homepage "https://github.com/wardle/hermes"
  url "https://github.com/wardle/hermes/releases/download/v1.4.1582/hermes-1.4.1582-lucene10.jar"
  version "1.4.1582"
  sha256 "30733f832e9a8049860ee2afb6ca35478092c7f31425507c414618f69a4f6ce2"
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
