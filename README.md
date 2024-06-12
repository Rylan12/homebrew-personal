# Rylan12 Personal

A collection of formulae and commands I've created for my own convenience.

## How do I install these formulae?

`brew install rylan12/personal/<formula>`

Or `brew tap rylan12/personal` and then `brew install <formula>`.

## Command Documentation

For general Homebrew help, use `brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

For help regarding specific commands provided by this tap, check the descriptions below and use `brew help <command>`.

### `brew blame`

```sh
brew blame <formula|cask> [<revision>] [-L <line> | -L <start>,<end>]
```

Pass `-L` to choose which lines to annotate.
`-L <line>` will annotate only the given line while `-L <start>,<end>` will annotate the range of lines from `<start>` to `<end>`.
Leave `<start>` or `<end>` blank (keeping the comma) to annotate from the beginning of the file to `<end>` or from `<start>` to the end of the file respectively.

For example, `brew blame foo -L 16` will annotate only line 16 of `foo.rb` but `brew blame foo -L 16,` will annotate from line 16 to the end of `foo.rb`

A revision can also be passed as a second named argument.
For example, `brew blame foo aad80774352^` will annotate `foo.rb` starting from the parent commit to `aad80774352`.

### `brew check`

```sh
brew check [options]
```

Run the various checks needed before opening a PR in the [Homebrew/brew](https://github.com/Homebrew/brew) repository.

These checks include `brew tests`, `brew style`, `brew typecheck`, etc.

### `brew move-cask-core`

```sh
brew move-core-cask [options]
```

Move the `homebrew/core` and `homebrew/cask` taps into and out of `$HOMEBREW_LIBRARY/Taps` for API testing purposes.

If `--tap` or `--untap` are specified, the taps will be tapped or untapped, respectively.
If they are already in the appropriate location, they will be skipped.
Otherwise, they will toggle between being tapped and untapped (based on `homebrew/core,` if it exists).

If no location is specified with the `--location` flag, the taps will be moved into `$HOMEBREW_PREFIX/.hidden-taps`.
