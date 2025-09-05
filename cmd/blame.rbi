# typed: strict

class Homebrew::Cmd::Blame
  sig { returns(Homebrew::Cmd::Blame::Args) }
  def args; end
end

class Homebrew::Cmd::Blame::Args < Homebrew::CLI::Args
  sig { returns(T.nilable(String)) }
  def lines; end
end
