/* 

author: Vasyl Burov
email: vasylburov@gmail.com
discord: vasylburov

2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první 
a poslední srovnatelné období v dostupných datech cen a mezd?

**/

SELECT
	year,
	ROUND(AVG(avg_salary)) avg_salary,
	category_code,
	category,
	avg_price,
	ROUND(AVG(avg_salary) / avg_price) AS affordability
FROM t_Vasyl_Burov_project_SQL_primary_final
WHERE year IN (2006, 2018)
	AND category_code IN (114201, 111301)
GROUP BY year, category_code;
