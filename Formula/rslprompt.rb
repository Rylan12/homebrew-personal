class Rslprompt < Formula
  desc "Fast, async zsh shell prompt"
  homepage "https://github.com/Rylan12/rslprompt"
  url "https://github.com/Rylan12/rslprompt/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "6089bc192696cd02de280286bff73bf18248f0afd0875823517ba3a556ad1e09"
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
    output = shell_output(bin/"rslprompt")
             .gsub(/\e\[[0-9;]*m/, "")
             .gsub(/%[{}]/, "")
    assert_match(/~\s*❯/m, output)
  end
end
