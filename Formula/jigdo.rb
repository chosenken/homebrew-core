class Jigdo < Formula
  desc "Tool to distribute very large files over the internet"
  homepage "http://atterer.org/jigdo/"
  url "http://atterer.org/sites/atterer/files/2009-08/jigdo/jigdo-0.7.3.tar.bz2"
  sha256 "875c069abad67ce67d032a9479228acdb37c8162236c0e768369505f264827f0"
  revision 3

  bottle do
    sha256 "d7c7af1e33252cafe37d0d43ad9e122ce16e9dd541e4552d32a93f1e79db4343" => :sierra
    sha256 "8e1a5a2d8af459ea2bc7a4961ac83f98d5dcdb6c9134d48ce115741960721179" => :el_capitan
    sha256 "dd8599117276a905cbf3f0c892625c3af690f192ac746b32ee203fe6386c0233" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "wget" => :recommended
  depends_on "berkeley-db"
  depends_on "gtk+"

  # Use MacPorts patch for compilation on 10.9; this software is no longer developed.
  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/e101570/jigdo/patch-src-compat.hh.diff"
    sha256 "a21aa8bcc5a03a6daf47e0ab4e04f16e611e787a7ada7a6a87c8def738585646"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "version #{version}", shell_output("#{bin}/jigdo-file -v")
  end
end
