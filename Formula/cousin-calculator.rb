class CousinCalculator < Formula
  desc 'Calculator to convert my family tree numbering scheme to the form "nth cousin m times removed"'
  homepage "https://github.com/Rylan12/CousinCalculator/tree/v0.1.0"
  url "https://github.com/Rylan12/CousinCalculator/archive/v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "5a0a9546593cc3049a9064e39e34e2faec3ca0952856b3ba3e35463b83fe1560"
  license "MIT"
  head "https://github.com/Rylan12/CousinCalculator.git"

  depends_on "ruby"

  resource "colorize" do
    url "https://rubygems.org/downloads/colorize-0.8.1.gem"
    sha256 "0ba0c2a58232f9b706dc30621ea6aa6468eeea120eb6f1ccc400105b90c4798c"
  end

  resource "ordinalize_full" do
    url "https://rubygems.org/downloads/ordinalize_full-1.6.0.gem"
    sha256 "cbf6e145d5e1586c37eafb3f44f0d2f850bb77fd46ee5ad70d9128b810f7086c"
  end

  def install
    ENV["GEM_HOME"] = libexec
    resources.each do |r|
      r.fetch
      system "gem", "install", r.cached_download, "--ignore-dependencies",
             "--no-document", "--install-dir", libexec
    end

    libexec.install "cousin-calculator.rb"
    bin.write_exec_script libexec/"cousin-calculator.rb"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    assert_equal "Same person", shell_output("#{bin}/cousin-calculator 1.2.1.2.8.1.2.1")
    assert_equal "3rd great grandchild", shell_output("#{bin}/cousin-calculator 1.2.1.2.8.1.2.1.9.9.9.9.9")
    assert_equal "4th great grand nibling", shell_output("#{bin}/cousin-calculator 1.2.1.2.8.1.2.9.9.9.9.9.9.9")
    assert_equal "5th cousin", shell_output("#{bin}/cousin-calculator 1.2.9.9.9.9.9.9")
    assert_equal "2nd cousin, 3 times removed", shell_output("#{bin}/cousin-calculator 1.2.9.9.9")
  end
end
