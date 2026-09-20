-- Migration V1: Create messages table for Communication Service
-- Bounded Context: Communication (ADR-003: Database per Service)
-- Database Engine: PostgreSQL 16
-- Database: communication_db

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID NOT NULL,
    receiver_id UUID NOT NULL,
    subject_id UUID,
    content VARCHAR(2000) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for querying conversation threads between two participants
CREATE INDEX IF NOT EXISTS idx_messages_conversation ON messages (sender_id, receiver_id);

-- Index for ordering messages chronologically
CREATE INDEX IF NOT EXISTS idx_messages_created_at ON messages (created_at);
