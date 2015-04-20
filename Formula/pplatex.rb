class Pplatex < Formula
  homepage "http://www.stefant.org/web/projects/software/pplatex.html"
  url "https://dl.dropbox.com/u/12697903/pplatex/pplatex-1.0-rc1-src.tar.gz"
  sha256 "27f7ff0fc38bfc4b46325bb15b17278ed09a65a2bf8c76a660a168f0a9006f11"

  depends_on "scons" => :build
  depends_on "pcre"
  depends_on :tex

  def install
    scons "PCREPATH=#{Formula["pcre"].opt_prefix}"
    bin.install "bin/pplatex", "bin/ppdflatex"
  end

  test do
    (testpath/"test.tex").write <<-'EOS'.undent
      \documentclass{article}
      \begin{document}
      Hello World!
      \end{document}
    EOS

    latex = which "latex"
    system bin/"pplatex", "--cmd", latex, "-q", "--", "test.tex"
    assert File.exist?("test.dvi")
  end
end
