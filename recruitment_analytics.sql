-- ============================================================
-- PROJECT 2: RECRUITMENT & HIRING ANALYTICS
-- ============================================================
-- Database: recruitment_analytics
-- Table: recruitment_data
-- Records: 1,500
-- Tools: PostgreSQL + SQL + Power BI
-- ============================================================


-- ============================================================
-- STEP 1: CREATE DATABASE
-- ============================================================

CREATE DATABASE recruitment_analytics;


-- ============================================================
-- STEP 2: CONNECT TO recruitment_analytics
-- ============================================================
-- In pgAdmin, open Query Tool under the recruitment_analytics
-- database before running the remaining queries.


-- ============================================================
-- STEP 3: CREATE TABLE
-- ============================================================

CREATE TABLE recruitment_data (
    age INT,
    gender INT,
    education_level INT,
    experience_years INT,
    previous_companies INT,
    distance_from_company DECIMAL(10,2),
    interview_score INT,
    skill_score INT,
    personality_score INT,
    recruitment_strategy INT,
    hiring_decision INT
);


-- ============================================================
-- STEP 4: VERIFY TABLE
-- ============================================================

SELECT *
FROM recruitment_data
LIMIT 10;


-- ============================================================
-- STEP 5: DATA VALIDATION
-- ============================================================


-- Check total number of records

SELECT COUNT(*) AS total_records
FROM recruitment_data;


-- Check for missing values

SELECT
    COUNT(*) FILTER (WHERE age IS NULL) AS age_missing,
    COUNT(*) FILTER (WHERE gender IS NULL) AS gender_missing,
    COUNT(*) FILTER (WHERE education_level IS NULL) AS education_missing,
    COUNT(*) FILTER (WHERE experience_years IS NULL) AS experience_missing,
    COUNT(*) FILTER (WHERE previous_companies IS NULL) AS companies_missing,
    COUNT(*) FILTER (WHERE distance_from_company IS NULL) AS distance_missing,
    COUNT(*) FILTER (WHERE interview_score IS NULL) AS interview_missing,
    COUNT(*) FILTER (WHERE skill_score IS NULL) AS skill_missing,
    COUNT(*) FILTER (WHERE personality_score IS NULL) AS personality_missing,
    COUNT(*) FILTER (WHERE recruitment_strategy IS NULL) AS strategy_missing,
    COUNT(*) FILTER (WHERE hiring_decision IS NULL) AS hiring_missing
FROM recruitment_data;


-- Check hiring decision distribution

SELECT
    hiring_decision,
    COUNT(*) AS candidate_count
FROM recruitment_data
GROUP BY hiring_decision
ORDER BY hiring_decision;


-- ============================================================
-- COLUMN MAPPINGS
-- ============================================================

-- Hiring Decision:
-- 0 = Not Hired
-- 1 = Hired

-- Education Level:
-- 1 = Bachelor's (Type 1)
-- 2 = Bachelor's (Type 2)
-- 3 = Master's
-- 4 = PhD


-- ============================================================
-- SECTION A: BASIC ANALYSIS
-- ============================================================


-- Q1. What is the total number of candidates?

SELECT
    COUNT(*) AS total_candidates
FROM recruitment_data;


-- Q2. How many candidates were hired and how many were not hired?

SELECT
    hiring_decision,
    COUNT(*) AS candidate_count
FROM recruitment_data
GROUP BY hiring_decision
ORDER BY hiring_decision;


-- Q3. What is the overall hiring rate?

SELECT
    ROUND(
        SUM(hiring_decision) * 100.0 / COUNT(*),
        2
    ) AS hiring_rate
FROM recruitment_data;


-- Q4. How many candidates are there in each education level?

SELECT
    CASE
        WHEN education_level = 1 THEN 'Bachelor''s (Type 1)'
        WHEN education_level = 2 THEN 'Bachelor''s (Type 2)'
        WHEN education_level = 3 THEN 'Master''s'
        WHEN education_level = 4 THEN 'PhD'
    END AS education,
    COUNT(*) AS candidate_count
FROM recruitment_data
GROUP BY education_level
ORDER BY education_level;


-- Q5. How many candidates are there under each recruitment strategy?

SELECT
    recruitment_strategy,
    COUNT(*) AS candidate_count
FROM recruitment_data
GROUP BY recruitment_strategy
ORDER BY recruitment_strategy;


-- ============================================================
-- SECTION B: CANDIDATE PROFILE ANALYSIS
-- ============================================================


-- Q6. What is the average age of candidates?

SELECT
    ROUND(AVG(age), 2) AS average_age
FROM recruitment_data;


-- Q7. What is the average years of experience?

SELECT
    ROUND(AVG(experience_years), 2) AS average_experience
FROM recruitment_data;


-- Q8. What is the average number of previous companies?

SELECT
    ROUND(AVG(previous_companies), 2) AS average_previous_companies
FROM recruitment_data;


-- Q9. What is the average distance from the company?

SELECT
    ROUND(AVG(distance_from_company), 2) AS average_distance
FROM recruitment_data;


-- Q10. How many candidates are there in each gender category?

SELECT
    gender,
    COUNT(*) AS candidate_count
FROM recruitment_data
GROUP BY gender
ORDER BY gender;


-- ============================================================
-- SECTION C: HIRING PERFORMANCE
-- ============================================================


-- Q11. What is the hiring rate for each education level?

SELECT
    education_level,
    COUNT(*) AS total_candidates,
    SUM(hiring_decision) AS hired_candidates,
    ROUND(
        SUM(hiring_decision) * 100.0 / COUNT(*),
        2
    ) AS hiring_rate
FROM recruitment_data
GROUP BY education_level
ORDER BY education_level;


-- Q12. What is the hiring rate for each recruitment strategy?

SELECT
    recruitment_strategy,
    COUNT(*) AS total_candidates,
    SUM(hiring_decision) AS hired_candidates,
    ROUND(
        SUM(hiring_decision) * 100.0 / COUNT(*),
        2
    ) AS hiring_rate
FROM recruitment_data
GROUP BY recruitment_strategy
ORDER BY hiring_rate DESC;


-- Q13. What is the hiring rate for each experience level?

SELECT
    experience_years,
    COUNT(*) AS total_candidates,
    SUM(hiring_decision) AS hired_candidates,
    ROUND(
        SUM(hiring_decision) * 100.0 / COUNT(*),
        2
    ) AS hiring_rate
FROM recruitment_data
GROUP BY experience_years
ORDER BY experience_years;


-- Q14. What is the average interview score for hired
-- vs. non-hired candidates?

SELECT
    hiring_decision,
    ROUND(AVG(interview_score), 2) AS average_interview_score
FROM recruitment_data
GROUP BY hiring_decision
ORDER BY hiring_decision;


-- Q15. What is the average skill score for hired
-- vs. non-hired candidates?

SELECT
    hiring_decision,
    ROUND(AVG(skill_score), 2) AS average_skill_score
FROM recruitment_data
GROUP BY hiring_decision
ORDER BY hiring_decision;


-- ============================================================
-- SECTION D: DEEPER BUSINESS ANALYSIS
-- ============================================================


-- Q16. What is the average personality score for hired
-- vs. non-hired candidates?

SELECT
    hiring_decision,
    ROUND(AVG(personality_score), 2) AS average_personality_score
FROM recruitment_data
GROUP BY hiring_decision
ORDER BY hiring_decision;


-- Q17. Which education level has the highest number
-- of hired candidates?

SELECT
    education_level,
    SUM(hiring_decision) AS hired_candidates
FROM recruitment_data
GROUP BY education_level
ORDER BY hired_candidates DESC
LIMIT 1;


-- Q18. Which recruitment strategy has the highest hiring rate?

SELECT
    recruitment_strategy,
    COUNT(*) AS total_candidates,
    SUM(hiring_decision) AS hired_candidates,
    ROUND(
        SUM(hiring_decision) * 100.0 / COUNT(*),
        2
    ) AS hiring_rate
FROM recruitment_data
GROUP BY recruitment_strategy
ORDER BY hiring_rate DESC
LIMIT 1;


-- Q19. Which experience level has the highest hiring rate?

SELECT
    experience_years,
    COUNT(*) AS total_candidates,
    SUM(hiring_decision) AS hired_candidates,
    ROUND(
        SUM(hiring_decision) * 100.0 / COUNT(*),
        2
    ) AS hiring_rate
FROM recruitment_data
GROUP BY experience_years
ORDER BY hiring_rate DESC
LIMIT 1;


-- Q20. Does the number of previous companies appear
-- to affect hiring?

SELECT
    previous_companies,
    COUNT(*) AS total_candidates,
    SUM(hiring_decision) AS hired_candidates,
    ROUND(
        SUM(hiring_decision) * 100.0 / COUNT(*),
        2
    ) AS hiring_rate
FROM recruitment_data
GROUP BY previous_companies
ORDER BY previous_companies;


-- ============================================================
-- SECTION E: ADVANCED SQL
-- ============================================================


-- Q21. Find candidates whose interview score is above
-- the overall average interview score.

SELECT
    age,
    experience_years,
    interview_score,
    hiring_decision
FROM recruitment_data
WHERE interview_score > (
    SELECT AVG(interview_score)
    FROM recruitment_data
)
ORDER BY interview_score DESC;


-- Q22. Find the top 10 candidates based on combined
-- interview + skill + personality scores.

SELECT
    age,
    experience_years,
    interview_score,
    skill_score,
    personality_score,
    (
        interview_score
        + skill_score
        + personality_score
    ) AS total_score,
    hiring_decision
FROM recruitment_data
ORDER BY total_score DESC
LIMIT 10;


-- Q23. Calculate hiring rate by education level
-- and recruitment strategy.

SELECT
    education_level,
    recruitment_strategy,
    COUNT(*) AS total_candidates,
    SUM(hiring_decision) AS hired_candidates,
    ROUND(
        SUM(hiring_decision) * 100.0 / COUNT(*),
        2
    ) AS hiring_rate
FROM recruitment_data
GROUP BY
    education_level,
    recruitment_strategy
ORDER BY
    education_level,
    recruitment_strategy;


-- Q24. Rank recruitment strategies based on hiring rate.

WITH strategy_performance AS (
    SELECT
        recruitment_strategy,
        COUNT(*) AS total_candidates,
        SUM(hiring_decision) AS hired_candidates,
        ROUND(
            SUM(hiring_decision) * 100.0 / COUNT(*),
            2
        ) AS hiring_rate
    FROM recruitment_data
    GROUP BY recruitment_strategy
)

SELECT
    recruitment_strategy,
    total_candidates,
    hired_candidates,
    hiring_rate,
    RANK() OVER (
        ORDER BY hiring_rate DESC
    ) AS strategy_rank
FROM strategy_performance
ORDER BY strategy_rank;


-- Q25. Identify the candidates with the strongest
-- overall assessment scores.

WITH candidate_scores AS (
    SELECT
        age,
        gender,
        education_level,
        experience_years,
        previous_companies,
        interview_score,
        skill_score,
        personality_score,
        hiring_decision,
        (
            interview_score
            + skill_score
            + personality_score
        ) AS total_score
    FROM recruitment_data
)

SELECT
    *,
    RANK() OVER (
        ORDER BY total_score DESC
    ) AS candidate_rank
FROM candidate_scores
ORDER BY candidate_rank
LIMIT 10;


-- ============================================================
-- END OF PROJECT 2 SQL ANALYSIS
-- ============================================================