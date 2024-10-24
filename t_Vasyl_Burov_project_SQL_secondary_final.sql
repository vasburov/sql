/* 
Secondary table of European states
t_Vasyl_Burov_project_SQL_secondary_final
*/

CREATE TABLE t_Vasyl_Burov_project_SQL_secondary_final AS 
WITH czechia AS (
	SELECT
    	e.year,
    	c.country,
    	e.population,
    	ROUND(e.GDP) AS gdp,
    	e.gini
	FROM countries c
	JOIN economies e ON c.country = e.country
	WHERE 
    	c.country = 'Czech Republic'
    	AND e.year BETWEEN 2006 AND 2018
), europe AS (
	SELECT
    	e.year,
    	c.country,
    	e.population,
    	ROUND(e.GDP) AS gdp,
    	e.gini
	FROM countries c
	JOIN economies e ON c.country = e.country
	WHERE 
    	c.continent = 'Europe'
    	AND e.year BETWEEN 2006 AND 2018
)
SELECT 
	e.year,
    c.population AS cz_population,
    c.gdp AS cz_gdp,
    c.gini AS cz_gini,
	e.country,
    e.population,
    e.gdp,
    e.gini
FROM europe e
JOIN czechia c ON e.year = c.year
ORDER BY e.year, c.country;
