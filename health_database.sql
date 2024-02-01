/* Team 06 11-18-2023 */
USE BMGT402_DB_Project_0101_Team_06

-- Create All Tables
CREATE TABLE t06_insurance (
	policy_id INT PRIMARY KEY NOT NULL,
	insurance_type VARCHAR(100),
	insurance_rate INT, 
	insurance_date DATE
);

CREATE TABLE t06_patient (
   	patient_num INT PRIMARY KEY NOT NULL,
   	patient_fname VARCHAR(100),
	patient_lname VARCHAR(100),
	patient_dob DATE,
	patient_email VARCHAR(100),
	policy_id INT,
	FOREIGN KEY (policy_id) REFERENCES t06_insurance(policy_id)
);


CREATE TABLE t06_appointment_note (
	note_file_id VARCHAR(5) PRIMARY KEY NOT NULL,
	patient_weight INT,
	patient_height CHAR(3), 
	patient_heart_rate INT,
	patient_blood_pressure INT, 
);

CREATE TABLE t06_staff_department (
	staff_department_id VARCHAR(6) PRIMARY KEY NOT NULL,
	staff_department_name VARCHAR(100),
	staff_department_description VARCHAR(300)
);

CREATE TABLE t06_staff (
	staff_id INT PRIMARY KEY NOT NULL,
	staff_fname VARCHAR(100),
	staff_lname VARCHAR(100),
	supervisor_id INT,
	staff_department_id VARCHAR(6),
	FOREIGN KEY (staff_department_id) REFERENCES t06_staff_department(staff_department_id)
);

CREATE TABLE t06_diagnosis (
	diagnosis_code VARCHAR(5) PRIMARY KEY NOT NULL,
	diagnosis_name VARCHAR(200),
	diagnosis_description VARCHAR(500)
);


CREATE TABLE t06_treatment (
	treatment_code VARCHAR(5) PRIMARY KEY,
	treatment_name VARCHAR(200),
	treatment_description VARCHAR(500) 
);

CREATE TABLE t06_diagnosis_treatment (
	diagnosis_code VARCHAR(5) NOT NULL,
	treatment_code VARCHAR(5) NOT NULL,
	PRIMARY KEY (diagnosis_code, treatment_code),
	FOREIGN KEY (diagnosis_code) REFERENCES t06_diagnosis(diagnosis_code),
	FOREIGN KEY (treatment_code) REFERENCES t06_treatment(treatment_code)
);

CREATE TABLE t06_appointment (
	patient_num INT NOT NULL,
	staff_id INT NOT NULL,
	appointment_date DATE NOT NULL,
	appointment_time TIME,
	note_file_id VARCHAR(5),
	appointment_reason VARCHAR(300),
	diagnosis_code VARCHAR(5),
	PRIMARY KEY (patient_num, staff_id, appointment_date),
	FOREIGN KEY (patient_num) REFERENCES t06_patient(patient_num),
	FOREIGN KEY (staff_id) REFERENCES t06_staff(staff_id),
	FOREIGN KEY (note_file_id) REFERENCES t06_appointment_note(note_file_id),
	FOREIGN KEY (diagnosis_code) REFERENCES t06_diagnosis(diagnosis_code)
);


-- add values to the tables
INSERT INTO  t06_insurance
VALUES
(1526512, 'BlueCross', 250, '2023-10-10'),
(1531772, 'United', 200, '2020-01-25'),
(9385928,'Mycigna', 230,'2021-10-11'),
(1492838,'United', 220,'2019-04-18'),
(4957393,'Aetna', 280,'2020-09-30');


INSERT INTO  t06_patient
VALUES
(8735, 'Elizabeth', 'Markey', '2001-05-12', 'emarkey@gmail.com', 1526512),
(1003, 'Ben', 'Shamer', '1995-12-30', 'bensham@yahoo.com', 1526512),
(3958,'Kyle','Smith', '1998-09-18','ksmith@gmail.com',9385928),
(1673, 'Jared', 'Oakes', '1999-01-30', 'joakes@gmail.com', 1492838),
(9785,'Serena','Mao','2000-11-12','smao1112@gmail.com',9385928);

INSERT INTO  t06_appointment_note
VALUES
(101, 127, 62, 84, 120),
(102,135,66,102,130),
(103,155,69,72,128),
(104,185,72,118,134),
(105, 230, 72, 58, 118);

INSERT INTO t06_staff_department
VALUES
('PED', 'Pediatrics', 'The branch of medicine dealing with children along with their diseases'),
('ORT', 'Orthopedics', 'the branch of medicine dealing with the correction of deformities of bones or muscles'),
('EMD','Emergency','fast-paced medical unit dedicated to providing immediate care for critical conditions and emergencies'),
('ICU','Intensive Care','specialized department where critically ill patients receive constant monitoring, advanced life 
	support, and intensive care to address complex and severe health issues'),
('CRD','Cardiovascular','branch that focuses on heart-related conditions and manages cardiac diseases'),
('PSY','Psychiatrics','dedicated to the assessment and treatment of mental health disorders');

INSERT INTO  t06_staff
VALUES
(2200075, 'Jerry', 'Feinstein', '1800212', 'PED'),
(1800221, 'Mark', 'Loon','0564713', 'ORT'),
(3958792,'Sarah','Lively','4838222','EMD'),
(2847283,'Hannah','Bakes','2957934','ICU'),
(3853883,'Julious','Klones','21342418','CRD'),
(2462398,'King','Jokes','92357809','PSY'),
(2200076, 'Susan', 'Smith', '1800212', 'PED'),
(2200077, 'Tom', 'Smith', '1800212', 'PED'),
(2200078, 'Ella', 'Taff', '1800212', 'PED'),
(2200079, 'Larry', 'Weaver', '1800212', 'PED'),
(2200080, 'Bob', 'Mattinger', '1800212', 'PED');

INSERT INTO  t06_diagnosis
VALUES
('D101', 'Diabetes', 'Diabetes is a chronic disease that occurs when blood glucose is too high.'),
('D102', 'Salmonellosis', 'Salmonellosis is an infection with salmonella bacteria that can cause 
	symptoms including diarrhea, fever, chills, and abdominal pain.'),
('D103','Hypertension','Hypertension is a medical condition where the blood pressure in the arteries is persistently elevated, 
	putting extra strain on the heart and blood vessels.'),
('D104','Asthma', 'Asthma is a chronic respiratory condition characterized by inflammation of the airways, leading to recurrent 
	episodes of wheezing, breathlessness, chest tightness, and coughing.'),
('D105','Rheumatoid Arthritis','Rheumatoid arthritis is an autoimmune disorder that primarily affects the joints, causing inflammation, pain, stiffness, and swelling.');

INSERT INTO  t06_treatment
VALUES
('T101', 'Insulin', '30 day insulin supply; must be taken once every day'),
('T102', 'Penicillin', '14-day prescription for 200mg antibiotics taken twice daily'),
('T103','Lisinopril','30-day supply, Take Lisinopril daily as prescribed'),
('T104','Fluticasone','30 day supply, Use Fluticasone daily; carry a rescue inhaler for emergencies'),
('T105','Methotrexate','60 day supply, Take methotrexate weekly as directed');

INSERT INTO t06_diagnosis_treatment
VALUES
('D101', 'T101'),
('D102', 'T102'),
('D103', 'T103'),
('D104', 'T104'),
('D105', 'T105');

INSERT INTO  t06_appointment
VALUES
(8735, 2200075, '2023-10-11', '13:00:00', '101', 'Patient often feels tired and weak', 'D101'),
(1003, 2200075, '2023-10-13', '11:00:00', '102', 'Patient is experiencing diarrhea, fever, and stomach cramps', 'D102'),
(3958,2200075,'2023-10-14','10:00:0','103','Patient feels lower back pain','D103'),
(1673,2847283,'2023-10-15','9:00:00','104','Patient feels throat discomfort','D104'),
(9785,3853883,'2023-10-16','10:00:00','105','Patient feels lower back pain','D105'), 
(9785,3853883,'2023-10-20','7:00:00','105','Patient feels lower back pain','D105'); 

-- show all data in tables
SELECT * FROM t06_patient;
SELECT * FROM t06_insurance;
SELECT * FROM t06_appointment_note;
SELECT * FROM t06_staff;
SELECT * FROM t06_staff_department;
SELECT * FROM t06_appointment;
SELECT * FROM t06_diagnosis_treatment;
SELECT * FROM t06_diagnosis;
SELECT * FROM t06_treatment;

-- create all views
GO 
CREATE VIEW t06_medical_information AS
SELECT d.diagnosis_code, d.diagnosis_name, d.diagnosis_description, t.treatment_code, t.treatment_name, t.treatment_description
FROM T06_DIAGNOSIS d
     INNER JOIN T06_DIAGNOSIS_TREATMENT dt ON dt.diagnosis_code = d.diagnosis_code
    INNER JOIN T06_TREATMENT t ON t.treatment_code = dt.treatment_code 
GO
CREATE VIEW t06_resources AS
SELECT sd.staff_department_id, sd.staff_department_name, a.staff_id, a.patient_num, a.appointment_date
FROM t06_staff_department sd 
    INNER JOIN t06_staff s ON s.staff_department_id = s.staff_department_id 
    INNER JOIN t06_appointment a ON a.staff_id = s.staff_id
GO


-- query a
SELECT an.patient_weight, an.patient_height, an.patient_heart_rate, an.patient_blood_pressure
FROM T06_APPOINTMENT_NOTE an 
    INNER JOIN T06_APPOINTMENT a ON a.note_file_id = an.note_file_id 
    INNER JOIN T06_PATIENT p ON p.patient_num = a.patient_num
WHERE  p.patient_fname = 'Elizabeth' AND p.patient_lname = 'Markey';

--query b 
SELECT p.patient_fname, p.patient_lname, p.patient_email, i.insurance_type 
FROM T06_PATIENT p 
    INNER JOIN T06_INSURANCE i ON i.policy_id = p.policy_id
WHERE i.insurance_type IN ('United', 'Aetna');

--query c
SELECT mi.diagnosis_name, mi.treatment_name
FROM t06_medical_information mi 
WHERE mi.diagnosis_name IN (
    SELECT d.diagnosis_name
    FROM t06_diagnosis d
        INNER JOIN t06_appointment a ON a.diagnosis_code = d.diagnosis_code
    WHERE a.appointment_date > '2000-01-01');

--query d
SELECT p.patient_num, p.patient_fname, p.patient_lname
FROM t06_patient p  
WHERE p.patient_num IN (
     SELECT a.patient_num 
     FROM t06_appointment a 
     WHERE a.appointment_date = '2023-10-13'); 

--query e 
SELECT s.staff_fname, s.staff_lname, s.staff_department_id
FROM t06_staff s
WHERE s.staff_id IN (
	SELECT staff_id
	FROM T06_APPOINTMENT
	GROUP BY staff_id
	HAVING COUNT(staff_id) >= 3);

--query f1
SELECT p.patient_num, p.patient_fname, p.patient_lname, p.patient_email
FROM T06_PATIENT p 
WHERE p.patient_num IN (
	SELECT a.patient_num
    FROM T06_APPOINTMENT a
           INNER JOIN T06_APPOINTMENT_NOTE an ON an.note_file_id = a.note_file_id
		INNER JOIN T06_PATIENT p ON p.patient_num = a.patient_num
    WHERE an.patient_heart_rate > 100 OR an.patient_heart_rate < 60 ); 


--query f2
SELECT r.staff_department_id, COUNT(r.staff_id) AS 'Number of Staff', COUNT(DISTINCT(r.patient_num)) AS 'Number of Patients'
FROM t06_resources r
GROUP BY r.staff_department_id
HAVING COUNT(r.staff_id) > 2 AND COUNT(DISTINCT(r.patient_num)) != 0;

-- drop all tables 
DROP TABLE IF EXISTS t06_appointment;
DROP TABLE IF EXISTS t06_patient;
DROP TABLE IF EXISTS t06_insurance;
DROP TABLE IF EXISTS t06_appointment_note;
DROP TABLE IF EXISTS t06_staff;
DROP TABLE IF EXISTS t06_staff_department;
DROP TABLE IF EXISTS t06_diagnosis_treatment;
DROP TABLE IF EXISTS t06_diagnosis;
DROP TABLE IF EXISTS t06_treatment;

-- drop all views
DROP VIEW IF EXISTS t06_medical_information;
DROP VIEW IF EXISTS t06_resources;