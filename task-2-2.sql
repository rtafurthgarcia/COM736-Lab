-- 1.
-- Retrieve the list of patients (Persons) who have been admitted to a specific ward.
SELECT * FROM patients 
WHERE patients.rooms_id = 4; -- Consult 401

-- 2.
-- List all operations performed by a specific surgeon (Staff).
SELECT * FROM performed_actions 
INNER JOIN performed_actions 
ON performed_actions.medical_staff_id = medical_staff.id
WHERE medical_staff.id = 3 -- From Michael

-- 3.
-- Get the total number of admissions per ward.
SELECT sum(rooms.id) AS Total, rooms.name AS Ward FROM admissions
INNER JOIN rooms 
ON rooms.id = admissions.rooms_id
GROUP BY name

-- 4.
-- Identify patients who have been admitted but have not yet received an operation.
SELECT patients.last_name, patients.medical_record_no 
FROM patients
INNER JOIN admissions 
ON admissions.patients_id = patients.id
INNER JOIN performed_actions
ON performed_actions.admissions_id = admissions.id
INNER JOIN actions
ON actions.id = performed_actions.actions_id
WHERE actions.action_types_id = 3 -- OP

-- 5.
-- Retrieve a list of operations of a specific type (OP_TYPE) performed within a given time period.
-- 6.
-- Find patients who received an operation and display their corresponding observations.
-- 7.
-- Determine the most frequently performed operation type in the hospital.
-- 8.
-- List staff members who have performed at least one operation as a surgeon or anaesthetist.
-- 9.
-- Identify admissions where the patient expected to receive an operation but did not.
-- 10.
-- Retrieve patients who have undergone multiple operations, listing the types of operations they received.