-- Database: SQLite
-- Dataset: Clinical Trial Efficacy Results
-- Author: Terryn Sanders
-- Date: 2026

--Queries--

-- Count trials by phase--
select 
coalesce (trial_phase, 'unknown') as phase,
count (*)  as  num_trials
FROM efficacy_df 
GROUP by trial_phase
ORDER by num_trials DESC;

-- Average enrollment for each trial phase --
SELECT 
 coalesce (trial_phase, 'unknown') as phase,
  AVG(enrollment_num) AS avg_enrollment
FROM efficacy_df
WHERE enrollment_num IS NOT NULL 
GROUP BY coalesce (trial_phase, 'unknown')
ORDER BY avg_enrollment DESC;

-- List trial stages and what conditions are being researched in each one --
SELECT
coalesce (trial_phase, 'unknown') as phase,
condition
FROM efficacy_df
group by condition 
order by phase;

-- List the trials that have missing enrollment data --
SELECT *
From efficacy_df 
WHERE enrollment_num is NULL
ORDER by NCT_ID DESC;

--Percentage of trials with missing enrollment data--
SELECT 
  ROUND(
    100.0 * SUM(CASE WHEN enrollment_num IS NULL  or enrollment_num = '' THEN 1 ELSE 0 END)
    / COUNT(*),
    2
  ) AS percent_missing_enrollment
FROM efficacy_df;

--List of funders and how many trials that they fund--
SELECT 
coalesce(funder_name, 'unknown') as funder,
count(*) as funded_trials
FROM efficacy_df
GROUP by funder
ORDER by funded_trials DESC;

--List of the top 10 clinical trial funders--
SELECT 
coalesce(funder_name, 'unknown') as funder,
count(*) as funded_trials
FROM efficacy_df
GROUP by funder
ORDER by funded_trials DESC Limit 10
