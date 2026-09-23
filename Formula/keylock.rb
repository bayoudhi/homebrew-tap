class Keylock < Formula
  desc "Run a command behind an input lock so stray keys can't interrupt it"
  homepage "https://github.com/bayoudhi/keylock"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bayoudhi/keylock/releases/download/v0.2.0/keylock-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1766c7354f70d7d37806e52aa7f0b3dec942356595fb08759dd199fc3a4140df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bayoudhi/keylock/releases/download/v0.2.0/keylock-cli-x86_64-apple-darwin.tar.xz"
      sha256 "127962db72345b4ede3b16a321226ed9b0d9eb982b778e7a337df95ea45df734"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bayoudhi/keylock/releases/download/v0.2.0/keylock-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5128d46ed741de73bb784a1cb1d9487c6650bd11e072627800db08ddc4c0e572"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bayoudhi/keylock/releases/download/v0.2.0/keylock-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "16fe665dd978a1456a883a0226501e872387301d8882cae0a4c2c385b7c370d5"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "keylock"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "keylock"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "keylock"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "keylock"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
