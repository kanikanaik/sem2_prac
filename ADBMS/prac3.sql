-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name TEXT,
    course_id INT
);

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    name TEXT
);

-- =========================
-- INSERT SAMPLE DATA
-- =========================

INSERT INTO course VALUES
(101,'CSE'),
(102,'DSA');

INSERT INTO student VALUES
(47,'Kuks',102),
(37,'Puks',101);

-- Add more rows so planner can show differences clearly
INSERT INTO student
SELECT generate_series(1,10000),
       'Student_' || generate_series(1,10000),
       101;

-- =========================
-- 1. SEQUENTIAL SCAN
-- =========================

-- No condition → full table scan
EXPLAIN
SELECT * FROM student;

-- You will usually see:
-- Seq Scan on student


-- =========================
-- CREATE INDEX
-- =========================

CREATE INDEX idx_roll
ON student(roll_no);

-- =========================
-- 2. INDEX SCAN
-- =========================

EXPLAIN ANALYZE
SELECT *
FROM student
WHERE roll_no = 47;

-- You should now see:
-- Index Scan using idx_roll


-- =========================
-- 3. JOIN OPERATION
-- =========================

EXPLAIN
SELECT s.name, c.name
FROM student s
JOIN course c
ON s.course_id = c.course_id;

-- Shows join strategy:
-- Nested Loop / Hash Join


-- =========================
-- 4. ORDER BY
-- =========================

EXPLAIN
SELECT *
FROM student
ORDER BY roll_no;

-- Since roll_no is indexed,
-- PostgreSQL may use:
-- Index Scan

-- Without index it may show:
-- Seq Scan + Sort