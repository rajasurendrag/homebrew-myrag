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

Nothing manual. `myrag` depends on the `ollama` formula, and on launch it automatically starts `ollama serve` if it isn't running and pulls the required models (`nomic-embed-text`, `llama3.2`) if they aren't present. The first run may take a few minutes while models download.

```bash
myrag
```

Vector data is stored in `~/Library/Application Support/my-rag/chroma_db`.

## Upgrading

```bash
brew upgrade myrag
```

Documents shipped with the app are versioned by content hash. If a new release changes the bundled documents, the next `myrag` run automatically rebuilds the vector store.
