USE projects;
SELECT * FROM hr;

-- QUESTIONS 
-- What is the gender breakdown of employees in this company?
USE projects;
SELECT gender, count(*) AS count
FROM hr
WHERE age > 18 AND termdate = '0000-00-00'
GROUP BY gender; 


-- What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) AS count
FROM hr
WHERE age > 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;


-- What is the age distribution of employees in the company?

SELECT 
min(age) AS youngest, 
max(age) AS olders
FROM hr
Where age >=18 AND termdate = '0000-00-00';

SELECT
  CASE
     WHEN age >=18 AND age <=24 THEN '18-24'
     WHEN age >=25 AND age <=34 THEN '25-34'
     WHEN age >=35 AND age <=44 THEN '35-44'
     WHEN age >=45 AND age <=54 THEN '45-54'
     WHEN age >=55 AND age <=64 THEN '55-64'
     ELSE '65+'
     END AS age_group,
     count(*) AS count
FROM hr
Where age >=18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

-- Gender distribution among age groups

SELECT
  CASE
     WHEN age >=18 AND age <=24 THEN '18-24'
     WHEN age >=25 AND age <=34 THEN '25-34'
     WHEN age >=35 AND age <=44 THEN '35-44'
     WHEN age >=45 AND age <=54 THEN '45-54'
     WHEN age >=55 AND age <=64 THEN '55-64'
     ELSE '65+'
     END AS age_group, gender,
     count(*) AS count 
FROM hr
Where age >=18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- Employees working at headquarters vs remote locations

SELECT location, count(*) AS count 
FROM hr
Where age >=18 AND termdate = '0000-00-00'
GROUP BY location;

-- Average length of employement for temrinated employees

SELECT 
   round(avg(datediff(termdate, hire_date))/365) as avg_length_employement
FROM HR
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >=18;

-- Gender distribution across departments and job titles
SELECT department, gender, COUNT(*) as count
FROM hr
Where age >=18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

-- Distribution of unique job titles 

SELECT jobtitle, count(*) AS count
FROM hr
Where age >=18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- Department with the highest turnover rate

SELECT department, 
 total_count,
 terminated_count,
 terminated_count/total_count AS termination_rate
 FROM (
 SELECT department,
 count(*) AS total_count,
 SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) as terminated_count
 FROM hr
 WHERE age >= 18
 GROUP BY department
 ) as subquery 
 ORDER BY termination_rate DESC;
 
 -- Distribution of Employees by city and state
 
 SELECT location_state, COUNT(*) AS count
 FROM hr
 WHERE age >= 18 AND termdate = '0000-00-00'
 GROUP BY location_state
 ORDER BY count DESC;
 
 -- Employee count has changed over time 
 
 SELECT
 year,
 hires,
 hires - terminations AS net_change,
 round((hires - terminations)/hires * 100, 2) AS net_change_percent
FROM(
SELECT year(hire_date) AS year,
count(*) as hires,
SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
FROM hr
WHERE age >= 18
GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY year ASC;

 