class ArcheyMacos < Formula
  desc "Graphical system information display for macOS"
  homepage "https://obihann.github.io/archey-osx/"
  url "https://github.com/Rylan12/archey-osx/archive/1.7.0.tar.gz"
  sha256 "be90b8327620338ee6567609e159aa22685206af227cbf5e363e48e64e3e3c1d"
  license "GPL-2.0-or-later"
  head "https://github.com/Rylan12/archey-osx"

  bottle :unneeded

  depends_on "jq"

  conflicts_with "archey", because: "both install an `archey` binary"

  def install
    bin.install "bin/archey"
  end

  test do
    assert_match "User:", shell_output("#{bin}/archey")
    assert_match "Archey OS X 1", shell_output("#{bin}/archey --help")
  end
end
