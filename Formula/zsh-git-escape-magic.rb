class ZshGitEscapeMagic < Formula
  desc "Zle tweak for git command-line arguments"
  homepage "https://github.com/knu/zsh-git-escape-magic"
  license "BSD-2-Clause"
  head "https://github.com/knu/zsh-git-escape-magic.git", branch: "master"

  def install
    # It's not technically completion, but it needs to be added to $fpath so this is the easiest way to do it.
    zsh_completion.install "git-escape-magic"
  end

  def caveats
    <<~EOS
      To activate the tweak, add the following lines to your .zshrc:

        autoload -Uz git-escape-magic
        git-escape-magic

      If you are enabling url-quote-magic, make sure to load it first and then load git-escape-magic.
      You will also need to restart your terminal for this change to take effect.
    EOS
  end

  test do
    zsh_command= "autoload -Uz git-escape-magic && git-escape-magic && which git-escape-magic"
    expected_output = <<~ZSH
      git-escape-magic () {
      \tgit-escape-magic.on
      }
    ZSH
    assert_match expected_output, shell_output("zsh -c '#{zsh_command}'")
  end
end
