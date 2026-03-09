class Rslprompt < Formula
  desc "Fast, async zsh shell prompt"
  homepage "https://github.com/Rylan12/rslprompt"
  url "https://github.com/Rylan12/rslprompt/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "086971b97b13c1afe3d807f618d66864e9b9def3adb521ea94189011c53602e2"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/rylan12/personal"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e638ae9990b7ff4416a95d2a3f1fb03e81ee410c4444daadc34b58e9c4b0a48a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9434645ba4440078351117e6dea6a60047304aec179576e9602c4c5e167fd6f8"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    output = shell_output(bin/"rslprompt")
             .gsub(/\e\[[0-9;]*m/, "")
             .gsub(/%[{}]/, "")
    assert_match(/~\s*❯/m, output)
  end
end
