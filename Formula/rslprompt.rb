class Rslprompt < Formula
  desc "Fast, async zsh shell prompt"
  homepage "https://github.com/Rylan12/rslprompt"
  url "https://github.com/Rylan12/rslprompt/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "15c5069504593f0a9213ccd1e6bcaac005b55035e3814d464bb9bc7d6dbde612"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/rylan12/personal"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "58145c7f399cf241f736ea6726c5f609ec0f823b86e45c0dcd679b577bca52d6"
    sha256 cellar: :any,                 x86_64_linux: "97f5337656e5bdafcbd3590ab430f45fd8b9308c0f2ac887c7f2341f4657448b"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Ensure this doesn't leak through from the caller's environment
    ENV["PWD"] = testpath
    output = shell_output(bin/"rslprompt")
             .gsub(/\e\[[0-9;]*m/, "")
             .gsub(/%[{}]/, "")
    assert_match(/~\s*❯/m, output)
  end
end
