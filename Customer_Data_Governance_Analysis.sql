/* =========================================================
   CUSTOMER DATA GOVERNANCE & GDPR RISK ASSESSMENT
   Company: NovaRetail Europe
   Project Type: Portfolio Case Study - Synthetic Data
   SQL Analysis: Data Quality & Data Governance
   ========================================================= */


/* 1. VIEW COMPLETE CUSTOMER DATASET */

SELECT *
FROM customers;


/* 2. TOTAL NUMBER OF RECORDS */

SELECT COUNT(*) AS total_records
FROM customers;


/* 3. MISSING EMAILS */

SELECT customer_id, full_name, email
FROM customers
WHERE email IS NULL;


/* 4. MISSING DATA CLASSIFICATION */

SELECT customer_id, full_name, data_classification
FROM customers
WHERE data_classification IS NULL;


/* 5. MISSING DATA OWNER */

SELECT customer_id, full_name, data_owner
FROM customers
WHERE data_owner IS NULL;


/* 6. DUPLICATE CUSTOMER IDs */

SELECT customer_id, COUNT(*) AS occurrences
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


/* 7. OUTDATED RECORDS */

SELECT customer_id, full_name, last_update
FROM customers
WHERE last_update < '2025-01-01';


/* 8. CUSTOMER RECORDS BY COUNTRY */

SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC;


/* 9. RECORDS BY DATA OWNER */

SELECT data_owner, COUNT(*) AS total_records
FROM customers
GROUP BY data_owner
ORDER BY total_records DESC;


/* 10. RECORDS REQUIRING DATA QUALITY / GOVERNANCE REVIEW */

SELECT
    customer_id,
    full_name,
    email,
    data_classification,
    data_owner,
    last_update
FROM customers
WHERE email IS NULL
   OR data_classification IS NULL
   OR data_owner IS NULL
   OR last_update < '2025-01-01';


/* 11. FINAL DATA QUALITY KPI SUMMARY */

SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE email IS NULL) AS missing_emails,
    COUNT(*) FILTER (
        WHERE data_classification IS NULL
    ) AS missing_classifications,
    COUNT(*) FILTER (
        WHERE data_owner IS NULL
    ) AS missing_data_owners,
    COUNT(*) FILTER (
        WHERE last_update < '2025-01-01'
    ) AS outdated_records,
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_records
FROM customers;


/* 12. AUTOMATED DATA QUALITY REVIEW STATUS */

SELECT
    customer_id,
    full_name,
    country,
    CASE
        WHEN email IS NULL
          OR data_classification IS NULL
          OR data_owner IS NULL
          OR last_update < '2025-01-01'
        THEN 'REVIEW'
        ELSE 'OK'
    END AS data_quality_status
FROM customers
ORDER BY customer_id;





