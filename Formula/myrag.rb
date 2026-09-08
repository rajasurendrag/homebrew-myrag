class Myrag < Formula
  desc "Local CLI RAG chatbot backed by LangChain, LangGraph, Ollama and ChromaDB"
  homepage "https://github.com/rajasurendrag/rag"
  url "https://github.com/rajasurendrag/rag/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "a7cef434dbb9ea277605d226060eafa30c622e7d51aa854125f0e82cdc52816e"

  depends_on "ollama"
  depends_on "python@3.13"

  def install
    python = formula_opt_bin("python@3.13")/"python3.13"
    system python, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", buildpath

    (bin/"myrag").write <<~SH
      #!/bin/bash
      marker="#{libexec}/.codesign-fixed"
      if [ ! -f "$marker" ]; then
        find "#{libexec}" \\( -name "*.so" -o -name "*.dylib" \\) -exec codesign --force --sign - {} \\; 2>/dev/null
        touch "$marker"
      fi
      exec "#{libexec}/bin/myrag" "$@"
    SH
    (bin/"myrag").chmod 0755
  end

  def caveats
    <<~EOS
      myrag starts Ollama and pulls the models it needs (nomic-embed-text,
      llama3.2) automatically on first run, so the first launch may take a
      few minutes.

      Run:

        myrag

      Vector data is stored in:
        ~/Library/Application Support/my-rag/chroma_db
    EOS
  end

  test do
    assert_path_exists bin/"myrag"
    assert_predicate bin/"myrag", :executable?
  end
end
