class Hermes < Formula
  desc "SNOMED CT terminology server, library and tools"
  homepage "https://github.com/wardle/hermes"
  url "https://github.com/wardle/hermes/releases/download/v1.4.1585/hermes-1.4.1585-lucene10.jar"
  version "1.4.1585"
  sha256 "456116efffc35aa7c3008c8828c1123822dc888398d5b4d51c5e94e68b2e8af2"
  license "EPL-2.0"

  depends_on "openjdk"

  def install
    libexec.install "hermes-#{version}-lucene10.jar" => "hermes.jar"
    (bin/"hermes").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk"].opt_bin}/java" \
        --add-modules jdk.incubator.vector \
        --enable-native-access=ALL-UNNAMED \
        --sun-misc-unsafe-memory-access=allow \
        -jar "#{libexec}/hermes.jar" "$@" \
        2> >(grep -v -E 'incubator|PanamaVectorizationProvider' >&2)
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/hermes --help")
  end
end
