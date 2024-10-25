/* 

author: Vasyl Burov
email: vasylburov@gmail.com
discord: vasylburov

Primary data table
t_Vasyl_Burov_project_SQL_primary_final

**/
	
CREATE OR REPLACE TABLE t_Vasyl_Burov_project_SQL_primary_final AS
WITH payroll AS (
	SELECT 
		p.payroll_year AS year, 
		p.industry_branch_code AS industry_code, 
		i.name AS industry_name,
		ROUND(AVG(p.value)) AS avg_salary 
	FROM czechia_payroll p
	JOIN czechia_payroll_industry_branch i ON p.industry_branch_code = i.code 
	WHERE 
		p.value_type_code ='5958'
		AND p.industry_branch_code IS NOT NULL
		AND p.payroll_year BETWEEN 2006 AND 2018
	GROUP BY p.payroll_year, p.industry_branch_code
), 
price AS (
	SELECT 
		YEAR(p.date_from) year,
		c.code category_code,
		c.name category,
		ROUND(AVG(p.value),2) avg_price
	FROM czechia_price p
	JOIN czechia_price_category c ON p.category_code = c.code 
	WHERE YEAR(p.date_from) BETWEEN 2006 AND 2018
	GROUP BY YEAR(p.date_from), p.category_code
), 
gdp AS (
	SELECT 
		year,
		ROUND(GDP) AS gdp
	FROM economies
	WHERE country = 'Czech Republic'
)
SELECT
	p.year,
	p.industry_code,
	p.industry_name,
	p.avg_salary,
	r.category_code,	
	r.category,
	r.avg_price,
	g.gdp
FROM payroll p
JOIN price r ON p.year = r.year
JOIN gdp g ON p.year = g.year
ORDER BY p.year, p.industry_code, r.category_code;
