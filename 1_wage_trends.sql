/* 

author: Vasyl Burov
email: vasylburov@gmail.com
discord: vasylburov

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

*/

WITH up_down_years AS (
	SELECT 
		industry_code,
		year,
		industry_name,
		avg_salary,
		LAG(avg_salary) OVER (PARTITION BY industry_code ORDER BY year) AS last_year,
		CASE
			WHEN LAG(avg_salary) OVER (PARTITION BY industry_code ORDER BY year) < avg_salary THEN 1
			ELSE 0
		END	AS up_year,
		CASE
			WHEN LAG(avg_salary) OVER (PARTITION BY industry_code ORDER BY year) > avg_salary THEN 1
			ELSE 0
		END	AS down_year	
	FROM t_Vasyl_Burov_project_SQL_primary_final
	GROUP BY industry_code, year
)
SELECT 
	industry_code,
	industry_name,
	SUM(up_year) AS up_years,
	SUM(down_year) AS down_years
FROM up_down_years
GROUP BY industry_code
ORDER BY up_years DESC, industry_code;
