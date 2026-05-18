-- =====================================================
-- SESSION 1 : CONCURRENT TRANSACTIONS, LOCKING
-- AND DEADLOCK SIMULATION
-- =====================================================

-- Run this setup only once

CREATE TABLE account (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    balance INT
);

INSERT INTO account VALUES
(1, 'Priya', 5000),
(2, 'Amit', 3000);

SELECT * FROM account;


-- =====================================================
-- PART 1 : EXCLUSIVE LOCK
-- =====================================================

-- SESSION 1

BEGIN;

UPDATE account
SET balance = balance - 1000
WHERE id = 1;

-- Row id = 1 gets locked
-- Do NOT COMMIT yet

-- Now execute SESSION 2 queries

-- After Session 2 starts waiting:
COMMIT;

-- Lock released


-- =====================================================
-- PART 2 : SELECT FOR UPDATE
-- =====================================================

BEGIN;

SELECT * FROM account
WHERE id = 2
FOR UPDATE;

-- Row id = 2 gets locked

-- Execute Session 2 query now

COMMIT;

-- Lock released


-- =====================================================
-- PART 3 : DEADLOCK SIMULATION
-- =====================================================

BEGIN;

UPDATE account
SET balance = balance + 200
WHERE id = 1;

-- Session 1 locks row id = 1

-- Now execute first query from SESSION 2

UPDATE account
SET balance = balance + 200
WHERE id = 2;

-- Session 1 now waits for row id = 2

-- Deadlock occurs when Session 2 requests row id = 1


-- =====================================================
-- THEORY
-- =====================================================

-- UPDATE automatically creates EXCLUSIVE LOCK

-- FOR UPDATE locks rows during SELECT

-- COMMIT saves changes permanently

-- Deadlock:
-- Session 1 waits for Session 2
-- Session 2 waits for Session 1

-- PostgreSQL automatically detects deadlock
