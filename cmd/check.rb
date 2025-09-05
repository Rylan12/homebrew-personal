# typed: strict
# frozen_string_literal: true

module Homebrew
  module Cmd
    class Check < AbstractCommand
      cmd_args do
        description <<~EOS
          Run the various checks needed before opening a PR in the Homebrew/brew repository.

          By default, this runs `brew typecheck` and `brew style`.

          Optionally, run `brew tests`, `brew vale`, and/or `brew generate-man-completions`.
        EOS
        switch      "-t", "--tests",
                    description: "Run `brew tests`."
        switch      "--vale",
                    description: "Run `vale` to check the documentation style."
        switch      "--generate-man-completions",
                    description: "Run `brew generate-man-completions`."
        switch      "-f", "--fix",
                    description: "Pass the `--fix` option to `brew style`."
        switch      "--exit-on-failure",
                    description: "Exit if a single check fails instead of running all checks."
        flag        "--only=",
                    description: "Run only the specified command. Options are `typecheck`, `style`, `tests`, " \
                                 "`vale`, or `generate-man-completions`."
        comma_array "--except=",
                    description: "Don't run the specified checks. Options are `typecheck` or `style`."

        conflicts "only", "except"

        named_args :none
      end

      sig { override.void }
      def run
        if args.only && %w[style vale typecheck tc generate-man-completions tests].exclude?(args.only)
          raise ArgumentError,
                "`--only` must be either `style`, `vale`, `typecheck`, `generate-man-completions`, or `tests`."
        end

        if args.except&.any? { |check| %w[typecheck style].exclude?(check) }
          raise ArgumentError,
                "`--except` must only contain `typecheck` or `style`."
        end

        run_typecheck = run_check?("typecheck", args: args) || run_check?("tc", args: args)
        run_style = run_check?("style", args: args)
        run_vale = args.vale? || run_check?("vale", args: args, default: false)
        run_man = args.generate_man_completions? || run_check?("generate-man-completions", args: args, default: false)
        run_tests = args.tests? || run_check?("tests", args: args, default: false)

        raise ArgumentError, "`--fix` cannot be passed unless style checks are being run." if !run_style && args.fix?

        require_relative "../lib/check"

        # As this command is simplifying user-run commands then let's just use a
        # user path, too.
        ENV["PATH"] = ENV.fetch("HOMEBREW_PATH", nil)

        failures = []

        typecheck_command = %w[typecheck]
        if run_typecheck && !Homebrew::Check.run_brew_command(typecheck_command,
                                                              exit_on_failure: args.exit_on_failure?)
          failures << typecheck_command.join(" ")
        end

        style_command = %w[style --display-cop-names]
        style_command << "--fix" if args.fix?
        if run_style && !Homebrew::Check.run_brew_command(style_command, exit_on_failure: args.exit_on_failure?)
          failures << style_command.join(" ")
        end

        vale_command = %W[vale --config #{HOMEBREW_REPOSITORY}/.vale.ini #{HOMEBREW_REPOSITORY}/docs/]
        if run_vale && !Homebrew::Check.run_shell_command(vale_command, exit_on_failure: args.exit_on_failure?)
          failures << vale_command.join(" ")
        end

        man_command = %w[generate-man-completions]
        Homebrew::Check.run_brew_command(man_command, ignore_failure: true) if run_man

        tests_command = %w[tests]
        if run_tests && !Homebrew::Check.run_brew_command(tests_command, exit_on_failure: args.exit_on_failure?)
          failures << tests_command
        end

        if failures.empty?
          oh1 "Success!"
          return
        end

        Homebrew::Check.display_failure_message failures
        Homebrew.failed = true
      end

      sig { params(check: String, args: Homebrew::Cmd::Check::Args, default: T::Boolean).returns(T::Boolean) }
      def run_check?(check, args:, default: true)
        if args.except&.any?(check) ||
           (args.only && args.only != check)
          false
        else
          default
        end
      end
    end
  end
end
