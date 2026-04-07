class HermesSct < Formula
  desc "SNOMED CT terminology server, library and tools"
  homepage "https://github.com/wardle/hermes"
  url "https://github.com/wardle/hermes/releases/download/v1.4.1560/hermes-1.4.1560.jar"
  sha256 "019feeb660b3c3dc572d1e39da0356a7e16e5488a74bd10e19434c72fac5a0e7"
  license "EPL-2.0"

  depends_on "openjdk@17"

  def install
    libexec.install "hermes-#{version}.jar" => "hermes.jar"
    bin.write_jar_script libexec/"hermes.jar", "hermes"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/hermes --help")
  end
end
