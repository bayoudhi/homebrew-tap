class Keylock < Formula
  desc "Run a command behind an input lock so stray keys can't interrupt it"
  homepage "https://github.com/bayoudhi/keylock"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bayoudhi/keylock/releases/download/v0.1.2/keylock-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6381a1fd5822bb3a56463b1bcfa7be55bc545892abda36f4ba814868cc78791d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bayoudhi/keylock/releases/download/v0.1.2/keylock-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0d24850f942478cbf6976bf2a60263914bf7bd46c56a4a410d95b0fe04231ce5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bayoudhi/keylock/releases/download/v0.1.2/keylock-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "f1f176d889279a7b7927956dfc6a6b80939a94f3bd0f3ae113aff50afdf17f33"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bayoudhi/keylock/releases/download/v0.1.2/keylock-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "976fe2ecd9a4c814a9a12cdf33067949de5d2ceb012f7c8d8fc4ae11e8f19547"
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
