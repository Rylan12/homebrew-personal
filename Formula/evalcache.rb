class Evalcache < Formula
  desc "Zsh plugin to cache eval loads to improve shell startup time"
  homepage "https://github.com/mroth/evalcache"
  license "MIT"
  head "https://github.com/mroth/evalcache.git", branch: "master"

  def install
    pkgshare.install "evalcache.plugin.zsh"
  end

  def caveats
    <<~EOS
      To activate evalcache, add the following line to your .zshrc:

        source #{HOMEBREW_PREFIX}/share/evalcache/evalcache.plugin.zsh

      You will also need to restart your terminal for this change to take effect.
    EOS
  end

  test do
    zsh_command = "source #{pkgshare}/evalcache.plugin.zsh && which _evalcache_clear"
    expected_output = <<~ZSH
      _evalcache_clear () {
      \trm -i "$ZSH_EVALCACHE_DIR"/init-*.sh
      }
    ZSH
    assert_match expected_output, shell_output("zsh -c '#{zsh_command}'")
  end
end
