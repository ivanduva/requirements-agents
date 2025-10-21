-- Database setup for RAG system
-- This assumes PostgreSQL with pgvector extension
-- Crear esquema
CREATE SCHEMA IF NOT EXISTS rag;

-- Enable the pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Table for storing document embeddings
CREATE TABLE IF NOT EXISTS rag.document_embeddings (
    id SERIAL PRIMARY KEY,
    chunk_id VARCHAR(255) UNIQUE NOT NULL,
    document_id VARCHAR(255) NOT NULL,
    filename VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    embedding vector(768), -- nomic-embed-text embedding dimension (adjust based on your model)
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_document_embeddings_document_id ON rag.document_embeddings(document_id);
CREATE INDEX IF NOT EXISTS idx_document_embeddings_filename ON rag.document_embeddings(filename);
CREATE INDEX IF NOT EXISTS idx_document_embeddings_embedding ON rag.document_embeddings USING ivfflat (embedding vector_cosine_ops);

