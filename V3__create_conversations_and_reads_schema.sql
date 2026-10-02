-- Migration V3: Create conversations, participants, and message reads
-- Bounded Context: Communication (ADR-003: Database per Service)
-- Standard: Aligned with educk-docs/09-microservices/services/07-communication/data-model.md

CREATE TABLE IF NOT EXISTS conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255),
    type VARCHAR(20) NOT NULL DEFAULT 'DIRECT' CHECK (type IN ('DIRECT', 'GROUP', 'BROADCAST')),
    school_id UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS conversation_participants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    user_id UUID NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'MEMBER',
    joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_conversation_participant UNIQUE(conversation_id, user_id)
);

CREATE TABLE IF NOT EXISTS message_reads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
    user_id UUID NOT NULL,
    read_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_message_user_read UNIQUE(message_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_conversations_school ON conversations (school_id);
CREATE INDEX IF NOT EXISTS idx_participants_user ON conversation_participants (user_id);
CREATE INDEX IF NOT EXISTS idx_reads_user ON message_reads (user_id);
