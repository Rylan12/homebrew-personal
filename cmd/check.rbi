# typed: strict

class Homebrew::Cmd::Check
  sig { returns(Homebrew::Cmd::Check::Args) }
  def args; end
end

class Homebrew::Cmd::Check::Args < Homebrew::CLI::Args
  sig { returns(T::Boolean) }
  def tests?; end

  sig { returns(T::Boolean) }
  def vale?; end

  sig { returns(T::Boolean) }
  def generate_man_completions?; end

  sig { returns(T::Boolean) }
  def fix?; end

  sig { returns(T::Boolean) }
  def exit_on_failure?; end

  sig { returns(T.nilable(String)) }
  def only; end

  sig { returns(T.nilable(T::Array[String])) }
  def except; end
end
