# Projekt z SQL

> Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují **dostupnost základních potravin široké veřejnosti**. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

> Potřebují k tomu **od vás připravit robustní datové podklady**, ve kterých bude možné vidět **porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období**.

> Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací **dalších evropských států** ve stejném období, jako primární přehled pro ČR.

> Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte `t_{jmeno}_{prijmeni}_project_SQL_primary_final` (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a `t_{jmeno}_{prijmeni}_project_SQL_secondary_final` (pro dodatečná data o dalších evropských státech).

> Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

> Na svém GitHub účtu vytvořte repozitář (může být soukromý), kam uložíte všechny informace k projektu – hlavně SQL skript generující výslednou tabulku, popis mezivýsledků (průvodní listinu) a informace o výstupních datech (například kde chybí hodnoty apod.).

## t_Vasyl_Burov_project_SQL_primary_final.sql
Data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky.

![Alt text](t_primary.png)

Pro vytvoření primární tabulky bylo potřeba zjistit společné roky dat o příjmech a cenách potravin. Zde je pomocný skript pro zjištění tohoto období:

```
WITH payroll_yrs AS (
    SELECT 
        MIN(payroll_year) AS min_year, 
        MAX(payroll_year) AS max_year
    FROM czechia_payroll
),
price_yrs AS (
    SELECT 
        MIN(YEAR(date_from)) AS min_year, 
        MAX(YEAR(date_from)) AS max_year
    FROM czechia_price
)
SELECT 
    GREATEST(pay.min_year, price.min_year) AS common_min_year,
    LEAST(pay.max_year, price.max_year) AS common_max_year
FROM payroll_yrs pay
JOIN price_yrs price;
```

## t_Vasyl_Burov_project_SQL_secondary_final.sql
Dodatečná data o dalších evropských státech.[^1]

![Alt text](t_secondary.png)

## 1_wage_trends.sql
> 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

## 2_milk_bread_comparison.sql
> 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

## 3_slowest_price_increase.sql
> 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

## 4_price_vs_wage_spike.sql
> 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

## 5_gdp_effect.sql
> 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

[^1]: Pochopil jsem "jako primární přehled pro ČR" tak, že mám do každého řádku přidat sloupce s daty pro Českou republiku, aby moji kolegové mohli snadno porovnávat data evropských zemí s ČR.
