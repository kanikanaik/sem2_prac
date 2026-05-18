-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE department (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    dep_id INT,
    FOREIGN KEY (dep_id) REFERENCES department(id)
);

-- =========================
-- INSERT DATA
-- =========================

INSERT INTO department(name)
VALUES
('Computer'),
('Medical'),
('Electrical');

INSERT INTO student(name, dep_id)
VALUES
('Alex', 1),
('Tom', 1),
('Ron', 3),
('Jon', 2),
('Shawn', 3);



-- =====================================================
-- 1. NESTED LOOP JOIN
-- =====================================================

SET enable_hashjoin = OFF;
SET enable_mergejoin = OFF;
SET enable_nestloop = ON;

EXPLAIN ANALYZE
SELECT s.id, s.name, d.name
FROM student s
JOIN department d
ON s.dep_id = d.id;

-- Output will show:
-- Nested Loop



-- =====================================================
-- 2. HASH JOIN
-- =====================================================

SET enable_hashjoin = ON;
SET enable_mergejoin = OFF;
SET enable_nestloop = OFF;

EXPLAIN ANALYZE
SELECT s.id, s.name, d.name
FROM student s
JOIN department d
ON s.dep_id = d.id;

-- Output will show:
-- Hash Join



-- =====================================================
-- 3. MERGE JOIN
-- =====================================================

SET enable_hashjoin = OFF;
SET enable_mergejoin = ON;
SET enable_nestloop = OFF;

EXPLAIN ANALYZE
SELECT s.id, s.name, d.name
FROM student s
JOIN department d
ON s.dep_id = d.id;

-- Output will show:
-- Merge Join