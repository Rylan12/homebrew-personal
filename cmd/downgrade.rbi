# typed: strict

class Homebrew::Cmd::Downgrade
  sig { returns(Homebrew::Cmd::Downgrade::Args) }
  def args; end
end

class Homebrew::Cmd::Downgrade::Args < Homebrew::CLI::Args
  sig { returns(T.nilable(String)) }
  def version; end
end
