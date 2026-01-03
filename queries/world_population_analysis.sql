USE WorldPopulationAnalytics;
GO

--------------------------------------------------
-- 1. Total population by continent (2022)
--------------------------------------------------
SELECT continent,
       SUM(population) AS total_population
FROM world_population
WHERE year = 2022
GROUP BY continent
ORDER BY total_population DESC;

--------------------------------------------------
-- 2. Top 5 most populated countries (2022)
--------------------------------------------------
SELECT TOP 5 country_name, population
FROM world_population
WHERE year = 2022
ORDER BY population DESC;

--------------------------------------------------
-- 3. Population growth from 2015 to 2022
--------------------------------------------------
SELECT w2022.country_name,
       w2015.population AS population_2015,
       w2022.population AS population_2022,
       (w2022.population - w2015.population) AS population_growth
FROM world_population w2022
JOIN world_population w2015
    ON w2022.country_name = w2015.country_name
WHERE w2022.year = 2022 AND w2015.year = 2015
ORDER BY population_growth DESC;

--------------------------------------------------
-- 4. Countries with population above global average (2022)
--------------------------------------------------
SELECT country_name, population
FROM world_population
WHERE year = 2022
AND population > (
    SELECT AVG(population)
    FROM world_population
    WHERE year = 2022
)
ORDER BY population DESC;

--------------------------------------------------
-- 5. Average population by continent (2022)
--------------------------------------------------
SELECT continent,
       AVG(population) AS avg_population
FROM world_population
WHERE year = 2022
GROUP BY continent
ORDER BY avg_population DESC;

--------------------------------------------------
-- 6. Rank countries by population (2022)
--------------------------------------------------
SELECT country_name,
       population,
       RANK() OVER (ORDER BY population DESC) AS population_rank
FROM world_population
WHERE year = 2022;

--------------------------------------------------
-- 7. Population percentage share by country (2022)
--------------------------------------------------
SELECT country_name,
       population,
       ROUND(population * 100.0 / SUM(population) OVER(), 2) AS population_percentage
FROM world_population
WHERE year = 2022
ORDER BY population_percentage DESC;

--------------------------------------------------
-- 8. Continent-wise population growth (2015–2022)
--------------------------------------------------
SELECT w2022.continent,
       SUM(w2022.population - w2015.population) AS population_growth
FROM world_population w2022
JOIN world_population w2015
    ON w2022.country_name = w2015.country_name
WHERE w2022.year = 2022 AND w2015.year = 2015
GROUP BY w2022.continent
ORDER BY population_growth DESC;

--------------------------------------------------
-- 9. Countries with declining or low growth
--------------------------------------------------
SELECT w2022.country_name,
       (w2022.population - w2015.population) AS growth
FROM world_population w2022
JOIN world_population w2015
    ON w2022.country_name = w2015.country_name
WHERE w2022.year = 2022 AND w2015.year = 2015
AND (w2022.population - w2015.population) < 2000000
ORDER BY growth;

--------------------------------------------------
-- 10. Running population total by rank (2022)
--------------------------------------------------
SELECT country_name,
       population,
       SUM(population) OVER (ORDER BY population DESC) AS cumulative_population
FROM world_population
WHERE year = 2022;

--------------------------------------------------
-- 11. Top populated country per continent (2022)
--------------------------------------------------
WITH ranked_countries AS (
    SELECT continent,
           country_name,
           population,
           RANK() OVER (PARTITION BY continent ORDER BY population DESC) AS rnk
    FROM world_population
    WHERE year = 2022
)
SELECT continent, country_name, population
FROM ranked_countries
WHERE rnk = 1;

--------------------------------------------------
-- 12. Population growth rate (%)
--------------------------------------------------
SELECT w2022.country_name,
       ROUND((w2022.population - w2015.population) * 100.0 / w2015.population, 2) AS growth_percentage
FROM world_population w2022
JOIN world_population w2015
    ON w2022.country_name = w2015.country_name
WHERE w2022.year = 2022 AND w2015.year = 2015
ORDER BY growth_percentage DESC;

--------------------------------------------------
-- 13. Countries contributing most to global growth
--------------------------------------------------
SELECT TOP 5 w2022.country_name,
       (w2022.population - w2015.population) AS population_growth
FROM world_population w2022
JOIN world_population w2015
    ON w2022.country_name = w2015.country_name
WHERE w2022.year = 2022 AND w2015.year = 2015
ORDER BY population_growth DESC;

--------------------------------------------------
-- 14. Continent population share (2022)
--------------------------------------------------
SELECT continent,
       ROUND(SUM(population) * 100.0 / SUM(SUM(population)) OVER(), 2) AS population_share_percent
FROM world_population
WHERE year = 2022
GROUP BY continent
ORDER BY population_share_percent DESC;

--------------------------------------------------
-- 15. Bottom 5 countries by population (2022)
--------------------------------------------------
SELECT TOP 5 country_name, population
FROM world_population
WHERE year = 2022
ORDER BY population ASC;

--------------------------------------------------
-- 16. Median population (2022)
--------------------------------------------------
SELECT PERCENTILE_CONT(0.5) 
WITHIN GROUP (ORDER BY population) 
OVER () AS median_population
FROM world_population
WHERE year = 2022;

--------------------------------------------------
-- 17. Countries above continent average
--------------------------------------------------
SELECT w.country_name,
       w.continent,
       w.population
FROM world_population w
JOIN (
    SELECT continent, AVG(population) AS avg_pop
    FROM world_population
    WHERE year = 2022
    GROUP BY continent
) c
ON w.continent = c.continent
WHERE w.year = 2022
AND w.population > c.avg_pop;

--------------------------------------------------
-- 18. Year-wise total population
--------------------------------------------------
SELECT year,
       SUM(population) AS total_population
FROM world_population
GROUP BY year
ORDER BY year;

--------------------------------------------------
-- 19. Country population trend (India)
--------------------------------------------------
SELECT year, population
FROM world_population
WHERE country_name = 'India'
ORDER BY year;

--------------------------------------------------
-- 20. Countries with highest growth rate
--------------------------------------------------
SELECT TOP 5 w2022.country_name,
       ROUND((w2022.population - w2015.population) * 100.0 / w2015.population, 2) AS growth_rate
FROM world_population w2022
JOIN world_population w2015
    ON w2022.country_name = w2015.country_name
WHERE w2022.year = 2022 AND w2015.year = 2015
ORDER BY growth_rate DESC;
