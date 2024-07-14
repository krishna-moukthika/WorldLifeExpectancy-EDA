#World Life Expectancy Project (Data CLeaning)

SELECT *
FROM world_life_expectancy; 

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
 FROM world_life_expectancy
 GROUP BY Country, Year, CONCAT(Country, Year)
 HAVING COUNT(CONCAT(Country, Year)) > 1;
 
SELECT * 
FROM( 
	SELECT Row_ID, CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
	FROM world_life_expectancy
	) AS Row_Table
WHERE Row_Num > 1
; 

DELETE FROM world_life_expectancy
WHERE Row_ID IN (
	SELECT Row_ID 
FROM( 
	SELECT Row_ID, CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
	FROM world_life_expectancy
	) AS Row_Table
WHERE Row_Num > 1
)
; 


SELECT *
FROM world_life_expectancy
WHERE status = ''; 

SELECT DISTINCT(status)
FROM world_life_expectancy
WHERE status <> ''; 

SELECT DISTINCT(country)
FROM world_life_expectancy
WHERE Status = 'Developing';

UPDATE world_life_expectancy w1
JOIN world_life_expectancy w2
	ON w1.country = w2.country
SET w1.status = 'Developing'
WHERE w1.status = ''
AND w2.status <> ''
AND w2.status = 'Developing'
;

UPDATE world_life_expectancy w1
JOIN world_life_expectancy w2
	ON w1.country = w2.country
SET w1.status = 'Developed'
WHERE w1.status = ''
AND w2.status <> ''
AND w2.status = 'Developed'
;

SELECT country, year, `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

SELECT w1.country, w1.year, w1.`Life expectancy`, 
w2.country, w2.year, w2.`Life expectancy`,
w3.country, w3.year, w3.`Life expectancy`,
ROUND((w2.`Life expectancy` + w3.`Life expectancy`)/2,1)
FROM world_life_expectancy w1
JOIN world_life_expectancy w2
	ON w1.country = w2.country
    AND w1.year = w2.year - 1
JOIN world_life_expectancy w3
	ON w1.country = w3.country
    AND w1.year = w3.year + 1
WHERE w1.`Life expectancy` = ''
;

UPDATE world_life_expectancy w1
JOIN world_life_expectancy w2
	ON w1.country = w2.country
    AND w1.year = w2.year - 1
JOIN world_life_expectancy w3
	ON w1.country = w3.country
    AND w1.year = w3.year + 1
SET w1.`Life expectancy` = ROUND((w2.`Life expectancy` + w3.`Life expectancy`)/2,1)
WHERE w1.`Life expectancy` = ''
;


#Exploratory Data Analysis

SELECT * FROM world_life_expectancy;

#Min and max life expectancy by country
SELECT Country, MIN(`Life expectancy`) AS Min_Life_Expectancy, MAX(`Life expectancy`) AS Max_Life_Expectancy
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0 AND MAX(`Life expectancy`) <> 0
ORDER BY Country DESC;

#Change in the life expectancy over the past 15 years
SELECT Country, 
       MIN(`Life expectancy`) AS Min_Life_Expectancy, 
       MAX(`Life expectancy`) AS Max_Life_Expectancy, 
       ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0 AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC;

#Average life expectancy by year
SELECT Year, ROUND(AVG(`Life expectancy`), 1) AS Avg_Life_Expectancy
FROM world_life_expectancy
WHERE `Life expectancy` <> 0 
GROUP BY Year
ORDER BY Year DESC;

#Correlation between GDP and life expectancy
SELECT Country, 
       ROUND(AVG(`Life expectancy`), 1) AS Avg_Life_Expectancy, 
       ROUND(AVG(GDP), 1) AS Avg_GDP
FROM world_life_expectancy
WHERE `Life expectancy` <> 0 AND GDP > 0
GROUP BY Country
ORDER BY Avg_GDP DESC;

#Categorize countries by GDP
SELECT 
    SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Count,
    ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END), 1) AS High_GDP_Life_Expectancy,
    SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Count,
    ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END), 1) AS Low_GDP_Life_Expectancy
FROM world_life_expectancy;

#Correlation between status and life expectancy
SELECT Status, ROUND(AVG(`Life expectancy`), 1) AS Avg_Life_Expectancy
FROM world_life_expectancy
GROUP BY Status;

#Correlation between BMI and life expectancy
SELECT Country, 
       ROUND(AVG(`Life expectancy`), 1) AS Avg_Life_Expectancy, 
       ROUND(AVG(BMI), 1) AS Avg_BMI
FROM world_life_expectancy
WHERE `Life expectancy` <> 0 AND BMI > 0
GROUP BY Country
ORDER BY Avg_BMI DESC;

#Rolling total of Adult Mortality for countries containing 'United'
SELECT Country, Year, `Life expectancy`, `Adult Mortality`, 
       SUM(`Adult Mortality`) OVER (PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%';