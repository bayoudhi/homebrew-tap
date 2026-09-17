class Keylock < Formula
  desc "Run a command behind an input lock so stray keys can't interrupt it"
  homepage "https://github.com/bayoudhi/keylock"
  url "https://github.com/bayoudhi/keylock/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "373df7426c517ae9b34d38708d5191aea13bf001fcab156374d534daa6429a4c"
  license "MIT"
  head "https://github.com/bayoudhi/keylock.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "keylock run", shell_output("#{bin}/keylock --help")
    assert_match "stdin is not a terminal", shell_output("#{bin}/keylock run -- true 2>&1", 2)
  end
end
