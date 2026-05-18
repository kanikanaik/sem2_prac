-- =====================================================
-- OBJECT ORIENTED CONCEPTS IN POSTGRESQL
-- =====================================================

-- This practical demonstrates:
-- 1. User Defined Type (UDT)
-- 2. Inheritance
-- 3. Encapsulation using Functions
-- 4. Abstraction using Views
-- 5. Composite Object Access
-- 6. Query Processing using EXPLAIN


-- =====================================================
-- 1. USER DEFINED TYPE (UDT)
-- =====================================================

-- Creating a custom datatype for address

CREATE TYPE address_type AS (
    street TEXT,
    city TEXT,
    state TEXT,
    pincode VARCHAR(6)
);


-- =====================================================
-- 2. PARENT TABLE
-- =====================================================

-- Parent table containing common attributes

CREATE TABLE Person (
    name TEXT,
    dob DATE,
    gender CHAR(1),
    address address_type,
    phone VARCHAR(15)
);


-- =====================================================
-- 3. INHERITANCE
-- =====================================================

-- Doctor table inherits properties from Person

CREATE TABLE Doctor (
    doctor_id SERIAL PRIMARY KEY,
    license_no VARCHAR(50) UNIQUE NOT NULL,
    specialization TEXT
) INHERITS (Person);


-- Patient table inherits properties from Person

CREATE TABLE Patient (
    patient_id SERIAL PRIMARY KEY,
    blood_group VARCHAR(5)
) INHERITS (Person);


-- =====================================================
-- 4. APPOINTMENT TABLE
-- =====================================================

CREATE TABLE Appointment (
    appointment_id SERIAL PRIMARY KEY,
    doctor_id INT REFERENCES Doctor(doctor_id),
    patient_id INT REFERENCES Patient(patient_id),
    appointment_date DATE,
    appointment_time TIME,
    reason TEXT
);


-- =====================================================
-- INSERT DATA INTO DOCTOR TABLE
-- =====================================================

INSERT INTO Doctor
(name, dob, gender, address, phone, license_no, specialization)
VALUES
(
    'Dr. Rajesh Sharma',
    '1980-05-12',
    'M',
    ROW('MG Road', 'Mumbai', 'Maharashtra', '400001'),
    '9876543210',
    'LIC12345',
    'Cardiologist'
),
(
    'Dr. Priya Mehta',
    '1985-08-20',
    'F',
    ROW('Link Road', 'Pune', 'Maharashtra', '411001'),
    '9123456780',
    'LIC67890',
    'Dermatologist'
);


-- =====================================================
-- INSERT DATA INTO PATIENT TABLE
-- =====================================================

INSERT INTO Patient
(name, dob, gender, address, phone, blood_group)
VALUES
(
    'Amit Joshi',
    '2000-02-10',
    'M',
    ROW('Station Road', 'Virar', 'Maharashtra', '401303'),
    '9988776655',
    'B+'
),
(
    'Sneha Patil',
    '1998-11-25',
    'F',
    ROW('Tilak Nagar', 'Thane', 'Maharashtra', '400601'),
    '8877665544',
    'O+'
);


-- =====================================================
-- INSERT DATA INTO APPOINTMENT TABLE
-- =====================================================

INSERT INTO Appointment
(doctor_id, patient_id, appointment_date, appointment_time, reason)
VALUES
(
    1,
    1,
    '2026-05-20',
    '10:30:00',
    'Chest Pain Checkup'
),
(
    2,
    2,
    '2026-05-21',
    '14:00:00',
    'Skin Allergy'
);


-- =====================================================
-- VIEW TABLE DATA
-- =====================================================

SELECT * FROM Doctor;

SELECT * FROM Patient;

SELECT * FROM Appointment;


-- =====================================================
-- ACCESSING DATA FROM PARENT TABLE
-- =====================================================

SELECT name, gender, phone
FROM Person;


-- =====================================================
-- 5. ENCAPSULATION USING FUNCTION
-- =====================================================

-- Function to calculate total appointments of a doctor

CREATE OR REPLACE FUNCTION total_appointments(doc_id INTEGER)
RETURNS INTEGER AS $$

BEGIN

    RETURN (
        SELECT COUNT(*)
        FROM Appointment
        WHERE doctor_id = doc_id
    );

END;

$$ LANGUAGE plpgsql;


-- Calling function

SELECT name, total_appointments(doctor_id)
FROM Doctor;


-- =====================================================
-- 6. ACCESSING ATTRIBUTES FROM UDT
-- =====================================================

-- Accessing state from address object

SELECT name, (address).state
FROM Person;


-- =====================================================
-- 7. ABSTRACTION USING VIEW
-- =====================================================

-- Creating a view to hide unnecessary columns

CREATE VIEW doc_detail AS

SELECT
    doctor_id,
    name,
    phone,
    license_no
FROM Doctor;


-- View data

SELECT * FROM doc_detail;


-- =====================================================
-- 8. QUERY PROCESSING
-- =====================================================

-- EXPLAIN shows query execution plan

EXPLAIN
SELECT * FROM Doctor;