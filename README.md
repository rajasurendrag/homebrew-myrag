# homebrew-myrag

Homebrew tap for [myrag](https://github.com/rajasurendrag/rag), a local CLI RAG chatbot backed by LangChain, LangGraph, Ollama and ChromaDB.

## Install

```bash
brew trust --tap rajasurendrag/myrag
brew tap rajasurendrag/myrag
brew install myrag
```

Trust must be granted **before** tapping. Homebrew 6.x refuses to clone an untrusted third-party tap, so running `brew tap` first will fail and leave the tap unregistered even after you trust it afterward.

## Requirements

myrag needs a local Ollama daemon with two models pulled before it will work:

```bash
brew install ollama
ollama serve &
ollama pull nomic-embed-text
ollama pull llama3.2
```

Then run:

```bash
myrag
```

Vector data is stored in `~/Library/Application Support/my-rag/chroma_db`.

## Upgrading

```bash
brew upgrade myrag
```

Documents shipped with the app are versioned by content hash. If a new release changes the bundled documents, the next `myrag` run automatically rebuilds the vector store.
