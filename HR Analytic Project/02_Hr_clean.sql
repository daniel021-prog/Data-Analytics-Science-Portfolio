/*
Project: HR Analytics Dashboard
Author: Daniel Mercedes
Database: PostgreSQL
Description: Data model, cleaning, and analytical queries for Power BI dashboard.
*/

-- ==================================================================================
--                                   DATA CLEANING
-- ==================================================================================

'Create dataset copy'

select * from hr

select * into hr_2 from hr 

select * from hr_2

---- Combine first_name, last_name, ---

select
 first_name, last_name,
 first_name ||' '|| last_name as user_name
 from hr_2

update hr_2
set first_name = first_name ||' '|| last_name 

alter table hr_2
drop column last_name 

alter table hr_2
rename column first_name to user_name 

--- Modify birthdate and hire_date----

alter table hr_2
alter column birthdate type date
using birthdate :: date 

alter table hr_2
alter column hire_date type date
using hire_date :: date 

---- Modify termdate------

alter table hr_2
alter column termdate type VARCHAR(20)

update hr_2
set termdate = '0000-00-00'
where termdate is null


----- alter termdate to TYPE DATE
ALTER TABLE hr_2
ALTER COLUMN termdate TYPE DATE
USING CASE
    WHEN termdate IS NOT NULL 
        AND termdate != '' 
        AND termdate NOT LIKE '0000-00-00%'
        AND termdate != '0001-01-01 BC'
    THEN termdate::DATE
    ELSE NULL
END;

----add age column-----

alter table hr_2
add column age int

-- Calculate age-----
update hr_2
set age = DATE_PART('year', age(CURRENT_DATE, birthdate));

-- View results----

SELECT birthdate, age FROM hr_2;

-- ====================================================================================
--                                          QUESTIONS FOR POWER BI
-- ====================================================================================

---1. What is the gender breakdown of employees in the company?

select gender, count(*)
from hr_2
where age >= 23 and age<= 60 
group by gender

----2.what is the race/ethnicity breakdown of employees in the company?
 select race, count(*)
 from hr_2
 group by race
 order by count(*) desc

----3. how many employees work at headquarters versus remote locations
select location, count(*)
from hr_2
where age >= 23 and age<= 60 
group by location


-- 4. What is the average length of employment for employees who have been terminated?
SELECT 
    ROUND(AVG(termdate - hire_date) / 365, 0) AS avg_length_employment
FROM hr_2
WHERE termdate <= CURRENT_DATE 
    AND termdate IS NOT NULL 
    AND age >= 23 and age<= 60 

 ---5. What is the age distribution of employees in the company 
 select min(age) , max(age) from hr_2

SELECT
    CASE
        WHEN age BETWEEN 23 AND 32 THEN '23-32'
        WHEN age BETWEEN 33 AND 42 THEN '33-42'
        WHEN age BETWEEN 43 AND 52 THEN '43-52'
        WHEN age BETWEEN 53 AND 60 THEN '53-60'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS count
FROM hr_2
GROUP BY age_group
ORDER BY age_group

--- 6. HOW does the gender distribution vary across departments and job title?
select department, gender, count(*)
from hr_2
where age >= 23 and age<= 60 
group by department, gender
order by department 

--- 7. What is the distribution of job titles across the company 
select jobtitle, count(*)
from hr_
where age >= 23 and age<= 60 
group by jobtitle 
order by jobtitle desc

---8. which department has the highest turnover rate?

SELECT 
    department,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE termdate IS NOT NULL AND termdate <= CURRENT_DATE) AS terminated,
    ROUND(
        COUNT(*) FILTER (WHERE termdate IS NOT NULL AND termdate <= CURRENT_DATE) 
        * 100.0 / COUNT(*), 2
    ) AS turnover_percentage
FROM hr_2
where age >= 23 and age<= 60 
GROUP BY department
ORDER BY turnover_percentage DESC;

--9. what is the distribution of employees across locations by city and state ? 

select location_city, location_state, count(*)
from hr_2
where age >= 23 and age<= 60 
group by location_city, location_state
order by location_state

--- 10. Employee by state
select location_state, count(*)
from hr_
where age >= 23 and age<= 60 
group by location_state
order by location_state desc

--11. Employee count change over time by year

SELECT
    CONCAT(
        (year / 4) * 4, 
        '-', 
        ((year / 4) * 4) + 3
    ) AS year_group,
    COUNT(*) AS employee_count
FROM (
    SELECT 
        generate_series(
            EXTRACT(YEAR FROM hire_date)::int,
            COALESCE(EXTRACT(YEAR FROM termdate)::int, EXTRACT(YEAR FROM CURRENT_DATE)::int)
        ) AS year
    FROM hr_2
) AS yearly
WHERE year BETWEEN 2000 AND 2026
GROUP BY year_group
ORDER BY year_group;

