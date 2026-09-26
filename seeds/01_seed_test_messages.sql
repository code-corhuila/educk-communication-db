-- Realistic Seed Fixtures for Communication Service (HU-005)
-- Purpose: Spin up functional local datasets representing authentic parent-teacher conversations,
-- multi-message conversation threads, and cross-user conversation isolation.

INSERT INTO messages (id, sender_id, receiver_id, subject_id, content, created_at)
VALUES 
    -- Thread 1: Parent (Ximena Zambrano) <-> Teacher (Carlos Mendoza) - Math Query
    ('a1111111-1111-1111-1111-111111111101', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', '33333333-3333-3333-3333-333333333333', 
     'Buenas tardes profesor Carlos, quisiera consultar sobre los temas evaluados en el examen parcial de álgebra del próximo viernes.', NOW() - INTERVAL '2 days'),
    
    ('a1111111-1111-1111-1111-111111111102', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', '33333333-3333-3333-3333-333333333333', 
     'Estimada Sra. Ximena, cordial saludo. Los temas corresponden a ecuaciones cuadráticas y factorización (capítulos 3 y 4 del texto guía). El estudiante ha mostrado excelente progreso.', NOW() - INTERVAL '1 day' - INTERVAL '4 hours'),

    ('a1111111-1111-1111-1111-111111111103', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', '33333333-3333-3333-3333-333333333333', 
     'Muchas gracias profesor por la pronta respuesta y el apoyo académico brindado.', NOW() - INTERVAL '5 hours'),

    -- Thread 2: Parent (Andres Gomez) <-> Teacher (Carlos Mendoza) - Follow-up
    ('b2222222-2222-2222-2222-222222222201', '44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', '33333333-3333-3333-3333-333333333333', 
     'Profesor Carlos, solicito cita de atención a padres para revisar el taller de nivelación.', NOW() - INTERVAL '3 hours'),

    -- Thread 3: Teacher (Laura Morales) -> Parent (Ximena Zambrano) - Physics Citation
    ('c3333333-3333-3333-3333-333333333301', '55555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', '66666666-6666-6666-6666-666666666666', 
     'Apreciada madre de familia, le informamos que la práctica de cinemática se desarrollará el próximo martes en el laboratorio central. Se requiere bata y guía impresa.', NOW() - INTERVAL '1 hour')
ON CONFLICT (id) DO NOTHING;
