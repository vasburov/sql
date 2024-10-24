-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP 
-- vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách 
-- ve stejném nebo násdujícím roce výraznějším růstem?

SELECT 
	year,
	gdp,
	ROUND((gdp / LAG(gdp) OVER (ORDER BY year) - 1) * 100,1) AS gdp_change_pcent,
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
ORDER BY ABS(gdp_change_pcent) DESC;