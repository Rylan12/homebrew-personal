class Rslprompt < Formula
  desc "Fast, async zsh shell prompt"
  homepage "https://github.com/Rylan12/rslprompt"
  url "https://github.com/Rylan12/rslprompt/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "d6577f778971e15de3f61f6ade1f86dbe1091a21f29120a598198e1753091956"
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
