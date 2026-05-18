-- =====================================================
-- SESSION 2 : CONCURRENT TRANSACTIONS, LOCKING
-- AND DEADLOCK SIMULATION
-- =====================================================


-- =====================================================
-- PART 1 : EXCLUSIVE LOCK
-- =====================================================

BEGIN;

UPDATE account
SET balance = balance + 500
WHERE id = 1;

-- This query waits because Session 1
-- already locked row id = 1

-- After Session 1 COMMIT:
-- Query executes automatically

COMMIT;


-- =====================================================
-- PART 2 : SELECT FOR UPDATE
-- =====================================================

BEGIN;

UPDATE account
SET balance = balance + 200
WHERE id = 2;

-- This query waits because Session 1
-- used SELECT FOR UPDATE

COMMIT;


-- =====================================================
-- PART 3 : DEADLOCK SIMULATION
-- =====================================================

BEGIN;

UPDATE account
SET balance = balance - 100
WHERE id = 2;

-- Session 2 locks row id = 2

UPDATE account
SET balance = balance - 50
WHERE id = 1;

-- Session 2 waits for row id = 1

-- Now:
-- Session 1 waits for row id = 2
-- Session 2 waits for row id = 1

-- DEADLOCK OCCURS

-- PostgreSQL automatically aborts one transaction


-- =====================================================
-- THEORY
-- =====================================================

-- Concurrent Transactions:
-- Multiple transactions running together

-- Locking prevents simultaneous modification
-- of same data

-- Deadlock occurs due to circular waiting

-- PostgreSQL detects deadlock automatically
