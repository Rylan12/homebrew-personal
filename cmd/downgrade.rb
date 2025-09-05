# typed: strict
# frozen_string_literal: true

require "unlink"

module Homebrew
  module Cmd
    class Downgrade < AbstractCommand
      DEFAULT_VERSION = "0.0.1"

      cmd_args do
        description <<~EOS
          Pretend to downgrade installed formulae to an earlier version.

          This doesn't actually install the earlier version, it overwrites the installed metadata
          to trick Homebrew into thinking the earlier version is installed.

          By default, this downgrades the formulae to version `0.0.1`.
        EOS
        flag "-t", "--version=",
             description: "Specify the version to use for downgrading."

        named_args :installed_formula, min: 1
      end

      sig { override.void }
      def run
        head_kegs = args.named.to_kegs.select { |keg| keg.version.head? }
        raise ArgumentError, "Cannot downgrade HEAD kegs: #{head_kegs.join(", ")}" if head_kegs.any?

        new_version = args.version || DEFAULT_VERSION

        args.named.to_kegs.each do |keg|
          old_path = Pathname(keg.to_path)
          new_path = old_path.parent/new_version

          odie "A keg for #{keg.name} version #{new_version} already exists at #{new_path}" if new_path.exist?

          keg_was_linked = keg.linked?
          if keg_was_linked
            odebug "Unlinking #{keg} before downgrading"
            Unlink.unlink(keg, verbose: args.verbose?)
          end

          tab = keg.tab
          tab.source["versions"]["stable"] = new_version
          tab.write

          FileUtils.mv(old_path, new_path)

          if keg_was_linked
            new_keg = Keg.new(new_path)
            new_keg.lock do
              odebug "Relinking #{new_keg} after downgrading"
              new_keg.link(verbose: args.verbose?)
            end
          end

          ohai "Downgraded #{keg.name} from version #{keg.version} to #{new_version}"
        end
      end
    end
  end
end
