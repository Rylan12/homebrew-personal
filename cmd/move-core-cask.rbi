# typed: strict

class Homebrew::Cmd::MoveCoreCask
  sig { returns(Homebrew::Cmd::MoveCoreCask::Args) }
  def args; end
end

class Homebrew::Cmd::MoveCoreCask::Args < Homebrew::CLI::Args
  sig { returns(T::Boolean) }
  def tap?; end

  sig { returns(T::Boolean) }
  def untap?; end

  sig { returns(T::Boolean) }
  def core_only?; end

  sig { returns(T::Boolean) }
  def cask_only?; end

  sig { returns(T::Boolean) }
  def status?; end

  sig { returns(T.nilable(String)) }
  def location; end
end
