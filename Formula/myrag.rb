class Myrag < Formula
  desc "Local CLI RAG chatbot backed by LangChain, LangGraph, Ollama and ChromaDB"
  homepage "https://github.com/rajasurendrag/rag"
  url "https://github.com/rajasurendrag/rag/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2b475f1aae6fd994c638f84914bd4c94052e8395a5a78b71991b973045f1b639"

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
      myrag needs a local Ollama daemon with two models pulled before it will work:

        brew install ollama
        ollama serve &
        ollama pull nomic-embed-text
        ollama pull llama3.2

      Then run:

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
