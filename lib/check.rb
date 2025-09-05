# typed: strict
# frozen_string_literal: true

require "english"
require "utils/output"

module Homebrew
  module Check
    module_function

    sig { params(command: T::Array[String], exit_on_failure: T::Boolean, ignore_failure: T::Boolean).returns(T::Boolean) }
    def run_brew_command(command, exit_on_failure: false, ignore_failure: false)
      command = [HOMEBREW_BREW_FILE.to_s, *command]
      run_shell_command command, exit_on_failure: exit_on_failure, ignore_failure: ignore_failure
    end

    sig { params(command: T::Array[String], exit_on_failure: T::Boolean, ignore_failure: T::Boolean).returns(T::Boolean) }
    def run_shell_command(command, exit_on_failure: false, ignore_failure: false)
      command_string = "#{File.basename(command.fetch(0))} #{command[1..]&.join(" ")}"
      Utils::Output.ohai command_string

      system(*command)

      if $CHILD_STATUS.success? || ignore_failure
        puts
        return true
      end

      if exit_on_failure
        display_failure_message([command_string])
        exit 1
      else
        Utils::Output.onoe "`#{command_string}` failed!"
        puts
        false
      end
    end

    sig { params(failure_cmds: T::Array[String]).void }
    def display_failure_message(failure_cmds)
      command_noun = failure_cmds.one? ? "command" : "commands"

      puts <<~MESSAGE
        #{Formatter.headline("Failure!", color: :red)}
        The following #{command_noun} failed:
          #{failure_cmds.map { |cmd| "brew #{cmd}" }.join("\n  ")}
      MESSAGE
    end
  end
end
