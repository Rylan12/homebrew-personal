class Rslprompt < Formula
  desc "Fast, async zsh shell prompt"
  homepage "https://github.com/Rylan12/rslprompt"
  url "https://github.com/Rylan12/rslprompt/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "15c5069504593f0a9213ccd1e6bcaac005b55035e3814d464bb9bc7d6dbde612"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/rylan12/personal"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2021f25b9205b67f85a49392a1bb334775259b562ae9f4a8773d13798af665cb"
    sha256 cellar: :any,                 x86_64_linux: "fe827aafe6b2616d0c5a3508f13da259cb7613fc403121ca72ab99fb6fc7e3d9"
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
