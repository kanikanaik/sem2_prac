-- =====================================================
-- FAILURE AND RECOVERY TECHNIQUES IN POSTGRESQL
-- =====================================================

-- This practical demonstrates:
-- 1. Log Based Recovery using WAL (Write Ahead Logging)
-- 2. Transaction Commit and Rollback
-- 3. Crash Recovery Simulation
-- 4. Shadow Paging Technique


-- =====================================================
-- PART A : LOG BASED RECOVERY (WAL)
-- =====================================================

-- WAL = Write Ahead Logging
-- PostgreSQL stores changes in log files before writing
-- actual data to disk. This helps in recovery after crash.

-- Check current WAL level

SHOW wal_level;


-- =====================================================
-- CREATE TABLE
-- =====================================================

CREATE TABLE recovery_test (
    id INT PRIMARY KEY,
    name TEXT
);


-- =====================================================
-- COMMITTED TRANSACTION
-- =====================================================

BEGIN;

INSERT INTO recovery_test
VALUES (1, 'Ron');

COMMIT;


-- Data is permanently saved

SELECT * FROM recovery_test;


-- =====================================================
-- UNCOMMITTED TRANSACTION
-- =====================================================

BEGIN;

INSERT INTO recovery_test
VALUES (2, 'Harry');

-- DO NOT COMMIT

-- Simulate crash by restarting PostgreSQL service


-- After restart:
-- PostgreSQL automatically removes uncommitted changes
-- using WAL recovery mechanism


SELECT * FROM recovery_test;

-- Output:
-- Only Ron will exist
-- Harry will not exist because transaction was not committed



-- =====================================================
-- PART B : SHADOW PAGING TECHNIQUE
-- =====================================================

-- Shadow Paging maintains:
-- 1. Original Copy
-- 2. Shadow Copy

-- If transaction succeeds:
-- Shadow copy becomes new database state

-- If failure occurs:
-- Original shadow copy is restored


-- =====================================================
-- CREATE MAIN TABLE
-- =====================================================

CREATE TABLE shadow_accounts (
    acc_no INT PRIMARY KEY,
    name TEXT,
    balance INT
);


-- =====================================================
-- INSERT INITIAL DATA
-- =====================================================

INSERT INTO shadow_accounts
VALUES (201, 'Rahul', 10000);


-- =====================================================
-- CREATE SHADOW COPY
-- =====================================================

CREATE TABLE shadow_copy AS
SELECT * FROM shadow_accounts;


-- =====================================================
-- UPDATE MAIN TABLE
-- =====================================================

UPDATE shadow_accounts
SET balance = balance + 100
WHERE acc_no = 201;


-- =====================================================
-- CASE 1 : COMMIT SUCCESSFUL
-- =====================================================

-- Accept changes

DROP TABLE shadow_copy;

CREATE TABLE shadow_copy AS
SELECT * FROM shadow_accounts;

-- Shadow copy now stores updated data



-- =====================================================
-- CASE 2 : FAILURE OCCURS
-- =====================================================

-- Discard modified table

DROP TABLE shadow_accounts;

-- Restore old shadow copy

ALTER TABLE shadow_copy
RENAME TO shadow_accounts;


-- =====================================================
-- VERIFY FINAL DATA
-- =====================================================

SELECT * FROM shadow_accounts;



-- =====================================================
-- CONCEPTS DEMONSTRATED
-- =====================================================

-- 1. WAL (Write Ahead Logging)
-- 2. Transaction Recovery
-- 3. Commit and Rollback
-- 4. Crash Recovery
-- 5. Shadow Paging
-- 6. Database Recovery Techniques


-- =====================================================
-- THEORY
-- =====================================================

-- LOG BASED RECOVERY:
-- Database changes are first written to log files.
-- If crash occurs:
-- 1. Committed transactions are REDONE
-- 2. Uncommitted transactions are UNDONE

-- SHADOW PAGING:
-- Database maintains shadow pages (backup copy).
-- Updates occur on new pages.
-- If transaction commits:
-- New pages replace old pages.
-- If crash occurs:
-- Old shadow pages restore database state.