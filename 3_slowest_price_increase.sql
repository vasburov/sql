/* 

author: Vasyl Burov
email: vasylburov@gmail.com
discord: vasylburov

3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší 
percentuální meziroční nárůst)?

*/

WITH price_2006 AS (
	SELECT
		year,
		category_code,
		category,
		avg_price 
	FROM t_Vasyl_Burov_project_SQL_primary_final
	WHERE year = 2006
), 
price_2018 AS (
	SELECT
		year,
		category_code,
		category,
		avg_price 
	FROM t_Vasyl_Burov_project_SQL_primary_final
	WHERE year = 2018
)
SELECT 
	p06.category_code,
	p06.category,
	p06.avg_price AS price_2006,
	p18.avg_price AS price_2018,
	ROUND(
		(p18.avg_price / p06.avg_price - 1) / (2018 - 2006) * 100,
		2
	) AS percent_yoy
FROM price_2006 p06
JOIN price_2018 p18 ON p06.category_code = p18.category_code
GROUP BY p06.category_code
ORDER BY percent_yoy;