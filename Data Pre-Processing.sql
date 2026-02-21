
-- View Full Data
SELECT * FROM credit_risk;

-- For Checking Size Of Data
SELECT COUNT(*) FROM credit_risk;

-- For Counting Null Values
SELECT 
    SUM(CASE WHEN client_ID IS NULL THEN 1 ELSE 0 END) AS client_ID_nulls,
    SUM(CASE WHEN person_age IS NULL THEN 1 ELSE 0 END) AS person_age_nulls,
    SUM(CASE WHEN person_income IS NULL THEN 1 ELSE 0 END) AS person_income_nulls,
    SUM(CASE WHEN person_home_ownership IS NULL THEN 1 ELSE 0 END) AS person_home_ownership_nulls,
    SUM(CASE WHEN person_emp_length IS NULL THEN 1 ELSE 0 END) AS person_emp_length_nulls,
    SUM(CASE WHEN loan_intent IS NULL THEN 1 ELSE 0 END) AS loan_intent_nulls,
    SUM(CASE WHEN loan_grade IS NULL THEN 1 ELSE 0 END) AS loan_grade_nulls,
    SUM(CASE WHEN loan_amnt IS NULL THEN 1 ELSE 0 END) AS loan_amnt_nulls,
    SUM(CASE WHEN loan_int_rate IS NULL THEN 1 ELSE 0 END) AS loan_int_rate_nulls,
    SUM(CASE WHEN loan_status IS NULL THEN 1 ELSE 0 END) AS loan_status_nulls,
    SUM(CASE WHEN loan_percent_income IS NULL THEN 1 ELSE 0 END) AS loan_percent_income_nulls,
    SUM(CASE WHEN cb_person_default_on_file IS NULL THEN 1 ELSE 0 END) AS cb_person_default_on_file_nulls,
    SUM(CASE WHEN cb_person_cred_hist_length IS NULL THEN 1 ELSE 0 END) AS cb_person_cred_hist_length_nulls,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_nulls,
    SUM(CASE WHEN marital_status IS NULL THEN 1 ELSE 0 END) AS marital_status_nulls,
    SUM(CASE WHEN education_level IS NULL THEN 1 ELSE 0 END) AS education_level_nulls,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_nulls,
    SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS state_nulls,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city_nulls,
    SUM(CASE WHEN city_latitude IS NULL THEN 1 ELSE 0 END) AS city_latitude_nulls,
    SUM(CASE WHEN city_longitude IS NULL THEN 1 ELSE 0 END) AS city_longitude_nulls,
    SUM(CASE WHEN employment_type IS NULL THEN 1 ELSE 0 END) AS employment_type_nulls,
    SUM(CASE WHEN loan_term_months IS NULL THEN 1 ELSE 0 END) AS loan_term_months_nulls,
    SUM(CASE WHEN loan_to_income_ratio IS NULL THEN 1 ELSE 0 END) AS loan_to_income_ratio_nulls,
    SUM(CASE WHEN other_debt IS NULL THEN 1 ELSE 0 END) AS other_debt_nulls,
    SUM(CASE WHEN debt_to_income_ratio IS NULL THEN 1 ELSE 0 END) AS debt_to_income_ratio_nulls,
    SUM(CASE WHEN open_accounts IS NULL THEN 1 ELSE 0 END) AS open_accounts_nulls,
    SUM(CASE WHEN credit_utilization_ratio IS NULL THEN 1 ELSE 0 END) AS credit_utilization_ratio_nulls,
    SUM(CASE WHEN past_delinquencies IS NULL THEN 1 ELSE 0 END) AS past_delinquencies_nulls
FROM credit_risk;

-- Fill person_emp_length with median, considering logical constraints (emp_length <= age)
UPDATE credit_risk
SET PERSON_EMP_LENGTH = 
    (SELECT MEDIAN(PERSON_EMP_LENGTH) 
     FROM credit_risk
     WHERE PERSON_EMP_LENGTH BETWEEN 0 AND PERSON_AGE)
WHERE PERSON_EMP_LENGTH IS NULL OR PERSON_EMP_LENGTH > PERSON_AGE;

-- Verify fill
SELECT 
    SUM(CASE WHEN person_emp_length IS NULL THEN 1 ELSE 0 END) AS person_emp_length_filled
FROM credit_risk;

-- -- Fill loan_int_rate with average per loan_grade
UPDATE credit_risk t
SET loan_int_rate = 
    (SELECT AVG(loan_int_rate)
     FROM credit_risk s
     WHERE s.loan_grade = t.loan_grade
       AND s.loan_int_rate IS NOT NULL)
WHERE t.loan_int_rate IS NULL;

-- -- Verify fill
SELECT 
    SUM(CASE WHEN loan_int_rate IS NULL THEN 1 ELSE 0 END) AS loan_int_rate_filled
FROM credit_risk;

SELECT * FROM credit_risk;

-- Remove extreme ages 
DELETE FROM credit_risk
WHERE person_age > 100;

-- Check and cap high debt_to_income_ratio 
SELECT COUNT(*) FROM credit_risk WHERE debt_to_income_ratio > 1;

UPDATE credit_risk
SET debt_to_income_ratio = 1.0
WHERE debt_to_income_ratio > 1.0;

-- Check other ratios
SELECT COUNT(*) FROM credit_risk WHERE loan_percent_income > 1;

SELECT COUNT(*) FROM credit_risk WHERE credit_utilization_ratio > 1;

-- Add descriptive column for loan_status
ALTER TABLE credit_risk
ADD loan_status_desc VARCHAR2(20);

UPDATE credit_risk
SET loan_status_desc = 
    CASE 
        WHEN loan_status = 0 THEN 'Non-Default'
        WHEN loan_status = 1 THEN 'Default'
        ELSE 'Unknown'          -- safety net for NULL or invalid values
    END;

-- Standardize default history    
UPDATE credit_risk
SET cb_person_default_on_file = 
    CASE 
        WHEN cb_person_default_on_file = 'Y' THEN 'Yes'
        WHEN cb_person_default_on_file = 'N' THEN 'No'
        ELSE 'Unknown'          -- safety net for NULL or invalid values
    END;

-- View cleaned data    
SELECT * FROM credit_risk;
    