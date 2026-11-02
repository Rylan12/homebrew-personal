class Rslprompt < Formula
  desc "Fast, async zsh shell prompt"
  homepage "https://github.com/Rylan12/rslprompt"
  url "https://github.com/Rylan12/rslprompt/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "15c5069504593f0a9213ccd1e6bcaac005b55035e3814d464bb9bc7d6dbde612"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/rylan12/personal"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6c16ed037e60773857b1b5eb60729d69b4a8b823ffcf142253927ca43c1c6514"
    sha256 cellar: :any,                 x86_64_linux: "816309cb736a779546cc7b434e44904278b894c9aded0ed7b78f12fc07e8f9e5"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Override to ensure this doesn't leak through from the caller's environment
    ENV["PWD"] = testpath
    output = shell_output(bin/"rslprompt")
             .gsub(/\e\[[0-9;]*m/, "")
             .gsub(/%[{}]/, "")
    assert_match(/~\s*❯/m, output)
  end
end
