-- Seeds for local development and integration testing
-- Aligned with api-execution-evidence.json verified snapshot

INSERT INTO messages (id, sender_id, receiver_id, subject_id, content, created_at)
VALUES 
    ('9b3816c1-cc25-4d92-92c4-22d238f183ac', 'c4974f76-1f6e-4e3a-97bb-43d995aa2bb3', 'd1952e42-78d1-4ad9-90ec-9a1bf07005c5', NULL, 'Evidence of running distributed system MVP for Sistemas Distribuidos 2026-B Corte 1.', NOW())
ON CONFLICT (id) DO NOTHING;
