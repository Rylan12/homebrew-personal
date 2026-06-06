class Rslprompt < Formula
  desc "Fast, async zsh shell prompt"
  homepage "https://github.com/Rylan12/rslprompt"
  url "https://github.com/Rylan12/rslprompt/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "d6577f778971e15de3f61f6ade1f86dbe1091a21f29120a598198e1753091956"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/rylan12/personal"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cc414875b8816c9d966072d0ce0e54a85ed21c0e1b3ffa0f50c01151241067a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7b0c8a65f3df05e08936ed86e29302f7b0888dfbaf17fd7c2a2ff6d15228facb"
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
