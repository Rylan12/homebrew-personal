class Actflow < Formula
  desc "Open-Source EDA Flow for Asynchronous Logic"
  homepage "https://avlsi.csl.yale.edu/act/doku.php"
  license "GPL-2.0-or-later"
  head "https://github.com/asyncvlsi/actflow.git", branch: "main"

  # Some of these can probably be trimmed down or converted to build dependencies
  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "fmt"
  depends_on "libedit"
  depends_on "libomp"
  depends_on "llvm"

  uses_from_macos "m4" => :build
  uses_from_macos "zlib"

  def install
    ENV.deparallelize

    ENV["ACT_HOME"] = prefix
    ENV["CXX"] = Formula["llvm"].opt_bin/"clang++"
    ENV["HOMEBREW_LIBOMP_PREFIX"] = Formula["libomp"].opt_prefix

    system "./build"
  end

  test do
    ENV["ACT_HOME"] = prefix

    (testpath/"test.act").write <<~ACT
      defproc inv(bool? in; bool! out) {
        prs {
          in => out-
        }
      }
    ACT

    (testpath/"test.scr").write <<~ACTSIM
      set in 0
      cycle
      get in
      get out
      set in 1
      cycle
      get in
      get out
    ACTSIM

    assert_match "in: 0\nout: 1\nin: 1\nout: 0", shell_output("#{bin}/actsim test.act inv < test.scr")
  end
end
