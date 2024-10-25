/* 

author: Vasyl Burov
email: vasylburov@gmail.com
discord: vasylburov

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší 
než růst mezd (větší než 10 %)?

*/

SELECT 
	year,
	salary,
	salary_change_pcent,
	price,
	price_change_pcent,
	price_change_pcent - salary_change_pcent AS delta
FROM (
	SELECT 
		year,
		ROUND(AVG(avg_salary)) salary,
		ROUND(
			(AVG(avg_salary) / LAG(AVG(avg_salary)) OVER (ORDER BY year) - 1) * 100,
			1
		) AS salary_change_pcent,
		ROUND(AVG(avg_price)) price,
		ROUND(
			(AVG(avg_price) / LAG(AVG(avg_price)) OVER (ORDER BY year) - 1) * 100,
			1
		) AS price_change_pcent
	FROM t_Vasyl_Burov_project_SQL_primary_final
	GROUP BY year
) AS subquery_not_to_repeat_all_the_calculations
ORDER BY delta DESC;
