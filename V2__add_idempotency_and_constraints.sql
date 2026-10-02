-- Migration V2: Add idempotency protection, delivery status, and participant integrity constraints
-- Bounded Context: Communication (HU-005)
-- Database Engine: PostgreSQL 16
-- Database: communication_db

-- 1. Add idempotency_key for correlation and duplicate prevention
ALTER TABLE messages 
    ADD COLUMN IF NOT EXISTS idempotency_key VARCHAR(64),
    ADD COLUMN IF NOT EXISTS status VARCHAR(20) NOT NULL DEFAULT 'SENT';

-- 2. Unique index ensuring duplicate message inserts on retry are rejected at database level
CREATE UNIQUE INDEX IF NOT EXISTS uq_messages_sender_idempotency 
    ON messages (sender_id, idempotency_key) 
    WHERE idempotency_key IS NOT NULL;

-- 3. Invariant constraint: Prevent self-addressed messages
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'chk_messages_distinct_participants'
    ) THEN
        ALTER TABLE messages 
            ADD CONSTRAINT chk_messages_distinct_participants 
            CHECK (sender_id <> receiver_id);
    END IF;
END $$;
