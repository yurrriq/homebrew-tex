class GitLatexdiff < Formula
  homepage "https://gitorious.org/git-latexdiff"
  url "https://gitorious.org/git-latexdiff/git-latexdiff.git",
    :tag => "v1.0.0",
    :revision => "c3f74f5559867111f118600e6d2bf778a3f13754"

  depends_on :tex
  depends_on "latexdiff" => :recommended

  def install
    bin.install "git-latexdiff"
  end

  test do
    test_git_dir = testpath/"gldtest"
    test_pdf = testpath/"test.pdf"
    system "git", "clone", "https://gitorious.org/git-latexdiff/git-latexdiff.git", test_git_dir
    (test_git_dir/"tests/bib").cd do
      system "git", "latexdiff", "@~5", "--no-view", "-o", test_pdf
    end
    assert File.exist?(test_pdf)
  end
end
