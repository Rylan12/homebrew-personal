# typed: strict
# frozen_string_literal: true

module Homebrew
  module Cmd
    class Blame < AbstractCommand
      cmd_args do
        usage_banner "`blame` <formula|cask> [<revision>] [-L <line> | -L <start>,<end>]"

        description <<~EOS
          Show `git blame` output of a <formula> or <cask>.
        EOS

        flag "-L", "--lines=",
             description: "Annotate only the given line range. " \
                          "`-L <line>` will annotate only the given line number. " \
                          "`-L <start>``,<end>` will annotate from <start> to <end>. " \
                          "Leave either <start> or <end> blank (keeping the comma) " \
                          "to annotate from the first line to <end> or from <start> " \
                          "to the last line respectively."
        named_args min: 1, max: 2
      end

      sig { override.void }
      def run
        name = args.named.fetch(0)
        revision = args.named[1]
        formula_path = Formulary.path name
        cask_path = Cask::CaskLoader.path name
        path = if File.exist? formula_path
          formula_path
        elsif File.exist? cask_path
          cask_path
        end

        odie "No available formula or cask with the name \"#{name}\"" if !path || !File.exist?(path)

        lines = args.lines
        lines = "#{lines},#{lines}" if lines.present? && lines.exclude?(",")

        git_blame path.dirname, path, revision, lines
      end

      sig { params(cd_dir: Pathname, path: Pathname, revision: T.nilable(String), lines: T.nilable(String)).void }
      def git_blame(cd_dir, path, revision, lines)
        Dir.chdir(cd_dir) do
          repo = Utils.popen_read("git", "rev-parse", "--show-toplevel").chomp

          if File.exist? "#{repo}/.git/shallow"
            tap = Tap.from_path(repo)
            opoo <<~EOS
              #{tap} is a shallow clone so only partial output will be shown.
              To get a full clone run:
                git -C $(brew --repo #{tap}) fetch --unshallow
            EOS
          end

          git_args = []
          git_args << revision if revision.present?
          git_args << "-L" << lines if lines.present?
          git_args += ["--", path] if path.present?
          system "git", "blame", *git_args
        end
      end
    end
  end
end
