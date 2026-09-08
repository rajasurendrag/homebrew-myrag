class Myrag < Formula
  include Language::Python::Virtualenv

  desc "Local CLI RAG chatbot backed by LangChain, LangGraph, Ollama and ChromaDB"
  homepage "https://github.com/rajasurendrag/rag"
  url "https://github.com/rajasurendrag/rag/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2b475f1aae6fd994c638f84914bd4c94052e8395a5a78b71991b973045f1b639"

  depends_on "python@3.13"

  def install
    venv = virtualenv_create(libexec, "python3.13")
    venv.pip_install_and_link buildpath
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
