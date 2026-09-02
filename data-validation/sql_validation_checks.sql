-- QA Data Validation Examples
-- Sample SQL checks commonly used for data quality
-- and source-to-target validation.

-- 1. Check for NULL values in required fields
SELECT *
FROM customers
WHERE customer_id IS NULL
   OR customer_name IS NULL
   OR email IS NULL;


-- 2. Identify duplicate records
SELECT
    customer_id,
    COUNT(*) AS record_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 3. Validate allowed business-rule values
SELECT *
FROM customers
WHERE status NOT IN ('Active', 'Inactive');


-- 4. Source-to-target record count validation
SELECT COUNT(*) AS source_count
FROM source_customers;

SELECT COUNT(*) AS target_count
FROM target_customers;


-- 5. Identify records missing from the target
SELECT s.customer_id
FROM source_customers s
LEFT JOIN target_customers t
    ON s.customer_id = t.customer_id
WHERE t.customer_id IS NULL;


-- 6. Identify source-to-target data mismatches
SELECT
    s.customer_id,
    s.customer_name AS source_name,
    t.customer_name AS target_name,
    s.email AS source_email,
    t.email AS target_email
FROM source_customers s
JOIN target_customers t
    ON s.customer_id = t.customer_id
WHERE s.customer_name <> t.customer_name
   OR s.email <> t.email;
