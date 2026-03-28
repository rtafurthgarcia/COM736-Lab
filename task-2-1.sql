INSERT INTO action_types (id, name) VALUES
(1, 'Diagnosis'),
(2, 'Observation'),
(3, 'Operation'),
(4, 'Prescription'),
(5, 'Lab Test');

INSERT INTO departments (id, name) VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'Ophthalmology'),
(5, 'Dentistry');

INSERT INTO room_types (id, name) VALUES
(1, 'General Ward'),
(2, 'ICU'),
(3, 'Operation Room'),
(4, 'Consultation Room'),
(5, 'Emergency Room');

INSERT INTO roles (id, name) VALUES
(1, 'Doctor'),
(2, 'Nurse'),
(3, 'Surgeon'),
(4, 'Anesthesiologist'),
(5, 'Radiologist');

INSERT INTO drugs (id, name) VALUES
(1, 'Paracetamol'),
(2, 'Ibuprofen'),
(3, 'Amoxicillin'),
(4, 'Metformin'),
(5, 'Lisinopril');

INSERT INTO instruments (id, name, added, expires_on) VALUES
(1, 'Stethoscope', CURRENT_TIMESTAMP, '2025-12-31 23:59:59'),
(2, 'Thermometer', CURRENT_TIMESTAMP, '2025-12-31 23:59:59'),
(3, 'Blood Pressure Monitor', CURRENT_TIMESTAMP, '2025-12-31 23:59:59'),
(4, 'Scalpel', CURRENT_TIMESTAMP, '2025-12-31 23:59:59'),
(5, 'X-ray Machine', CURRENT_TIMESTAMP, '2025-12-31 23:59:59');

INSERT INTO rooms (id, name, room_no, floor_no, room_types_id) VALUES
(1, 'Room A101', 101, 1, 1),
(2, 'ICU 201', 201, 2, 2),
(3, 'OR 301', 301, 3, 3),
(4, 'Consult 401', 401, 4, 4),
(5, 'ER 501', 501, 5, 5);

INSERT INTO medical_staff (id, departments_id, first_name, middle_name, last_name, date_of_birth, gender) VALUES
(1, 1, 'John', 'A.', 'Smith', '1975-03-15', 'Male'),
(2, 2, 'Emily', 'B.', 'Johnson', '1980-07-22', 'Female'),
(3, 3, 'Michael', 'C.', 'Williams', '1968-11-02', 'Male'),
(4, 4, 'Sarah', 'D.', 'Brown', '1990-05-10', 'Female'),
(5, 5, 'David', 'E.', 'Jones', '1985-09-18', 'Male');

INSERT INTO patients (id, first_name, middle_name, last_name, date_of_birth, gender, medical_record_no, rooms_id) VALUES
(1, 'Alice', 'F.', 'Miller', '1995-01-20', 'Female', 10001, 1),
(2, 'Bob', 'G.', 'Davis', '1988-04-12', 'Male', 10002, 2),
(3, 'Charlie', 'H.', 'Garcia', '1972-08-05', 'Male', 10003, 3),
(4, 'Diana', 'I.', 'Rodriguez', '2000-11-30', 'Female', 10004, 4),
(5, 'Eve', 'J.', 'Martinez', '1965-02-18', 'Female', 10005, 5);

INSERT INTO admissions (id, arrival_on, departure_on, rooms_id, patients_id, medical_staff_id) VALUES
(1, '2023-01-10 09:00:00', '2023-01-15 14:00:00', 1, 1, 1),
(2, '2023-02-05 11:30:00', '2023-02-10 10:00:00', 2, 2, 2),
(3, '2023-03-20 08:15:00', NULL, 3, 3, 3),
(4, '2023-04-12 14:45:00', '2023-04-18 09:30:00', 4, 4, 4),
(5, '2023-05-25 10:00:00', NULL, 5, 5, 5);

INSERT INTO actions (id, happened_on, action_types_id, parent_actions_id) VALUES
-- Diagnosis (type 1)
(1, '2023-01-11 10:00:00', 1, NULL),
(2, '2023-02-06 09:30:00', 1, NULL),
(3, '2023-03-21 11:15:00', 1, NULL),
(4, '2023-04-13 13:45:00', 1, NULL),
(5, '2023-05-26 08:00:00', 1, NULL),
-- Observation (type 2)
(6, '2023-01-12 14:00:00', 2, NULL),
(7, '2023-02-07 16:30:00', 2, NULL),
(8, '2023-03-22 09:00:00', 2, NULL),
(9, '2023-04-14 10:30:00', 2, NULL),
(10, '2023-05-27 12:45:00', 2, NULL),
-- Operation (type 3)
(11, '2023-01-13 08:00:00', 3, NULL),
(12, '2023-02-08 09:00:00', 3, NULL),
(13, '2023-03-23 10:00:00', 3, NULL),
(14, '2023-04-15 11:00:00', 3, NULL),
(15, '2023-05-28 12:00:00', 3, NULL),
-- Prescription (type 4)
(16, '2023-01-14 15:00:00', 4, NULL),
(17, '2023-02-09 16:00:00', 4, NULL),
(18, '2023-03-24 17:00:00', 4, NULL),
(19, '2023-04-16 18:00:00', 4, NULL),
(20, '2023-05-29 19:00:00', 4, NULL),
-- Lab Test (type 5)
(21, '2023-01-15 09:00:00', 5, NULL),
(22, '2023-02-10 10:00:00', 5, NULL),
(23, '2023-03-25 11:00:00', 5, NULL),
(24, '2023-04-17 12:00:00', 5, NULL),
(25, '2023-05-30 13:00:00', 5, NULL);

INSERT INTO diagnosis (id, description) VALUES
(1, 'Acute bronchitis'),
(2, 'Hypertension'),
(3, 'Fractured radius'),
(4, 'Pneumonia'),
(5, 'Type 2 diabetes');

INSERT INTO observations (id, notes) VALUES
(6, 'Patient reported chest pain, stable vitals.'),
(7, 'Headache and dizziness, prescribed medication.'),
(8, 'Post-operative recovery, wound healing well.'),
(9, 'Fever of 38.5°C, administered antipyretic.'),
(10, 'Routine check-up, no abnormalities.');

INSERT INTO operations (id, name) VALUES
(11, 'Appendectomy'),
(12, 'Knee replacement'),
(13, 'Cataract surgery'),
(14, 'Coronary bypass'),
(15, 'Hernia repair');

INSERT INTO prescriptions (id, valid_since, valid_until) VALUES
(16, '2023-01-14 15:00:00', '2023-02-14 23:59:59'),
(17, '2023-02-09 16:00:00', '2023-03-09 23:59:59'),
(18, '2023-03-24 17:00:00', '2023-04-24 23:59:59'),
(19, '2023-04-16 18:00:00', '2023-05-16 23:59:59'),
(20, '2023-05-29 19:00:00', '2023-06-29 23:59:59');

INSERT INTO plans (creation, initiator_id, patients_id, admissions_id, medical_staff_id) VALUES
('2023-01-10 08:00:00', 1, 1, 1, 1),
('2023-02-05 10:00:00', 2, 2, 2, 2),
('2023-03-20 07:30:00', 3, 3, 3, 3),
('2023-04-12 13:00:00', 4, 4, 4, 4),
('2023-05-25 09:30:00', 5, 5, 5, 5);

INSERT INTO performed_actions (admissions_id, planned_on, is_done, actions_id, roles_id, medical_staff_id, performed_on, rooms_id) VALUES
(1, '2023-01-11 09:00:00', 1, 1, 1, 1, '2023-01-11 10:00:00', 1),
(1, '2023-02-06 08:30:00', 1, 6, 1, 2, '2023-02-06 09:30:00', 2),
(3, '2023-03-21 10:00:00', 0, 11, 1, 3, '2023-03-21 11:15:00', 3),
(4, '2023-04-13 13:00:00', 1, 16, 1, 4, '2023-04-13 13:45:00', 4),
(5, '2023-05-26 07:30:00', 1, 21, 1, 5, '2023-05-26 08:00:00', 5);

INSERT INTO allowed_actions_per_role (since, actions_id, roles_id, allowed_until) VALUES
('2023-01-01 00:00:00', 1, 1, NULL),
('2023-02-01 00:00:00', 2, 2, '2023-12-31 23:59:59'),
('2023-03-01 00:00:00', 3, 3, NULL),
('2023-04-01 00:00:00', 4, 4, '2023-12-31 23:59:59'),
('2023-05-01 00:00:00', 5, 5, NULL);

INSERT INTO instruments_used_for (actions_id, instruments_id, used_on) VALUES
(1, 1, '2023-01-11 10:00:00'),
(2, 2, '2023-02-06 09:30:00'),
(3, 3, '2023-03-21 11:15:00'),
(4, 4, '2023-04-13 13:45:00'),
(5, 5, '2023-05-26 08:00:00');

INSERT INTO ordained_prescription (medical_staff_id, drugs_id, prescriptions_id, qte) VALUES
(1, 1, 16, 2),
(2, 2, 17, 1),
(3, 3, 18, 3),
(4, 4, 19, 1),
(5, 5, 20, 2);

INSERT INTO roles_held (held_since, medical_staff_id, roles_id, held_until) VALUES
('2020-01-01 00:00:00', 1, 1, NULL),
('2021-06-01 00:00:00', 2, 2, NULL),
('2019-03-15 00:00:00', 3, 3, NULL),
('2022-08-20 00:00:00', 4, 4, '2025-08-20 23:59:59'),
('2023-01-10 00:00:00', 5, 5, NULL);