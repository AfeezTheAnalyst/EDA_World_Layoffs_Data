-- EXPLORATORY DATA ANALYSIS

SELECT *
FROM layoffs_staging2;

-- Total employees laid off
SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- Companies that completely laid-off their staff ordered by total number of laid off
-- By fund raised in millions
-- Laid off by grouping company
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Ranking industry with the most layoffs
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Ranking country with the most layoffs
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Ranking by year and industry with the most layoffs
SELECT YEAR(`date`), industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`), industry
ORDER BY 3 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Layoffs per month using 12 calendar month
SELECT SUBSTRING(`date`, 1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1;

-- Rolling sum or running total of Layoffs per month using 12 calendar month using CTEs
WITH Rolling_total AS
(
SELECT SUBSTRING(`date`, 1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1
)
SELECT `MONTH`, total_off, SUM(total_off)
OVER (ORDER BY `MONTH`) AS running_total
FROM Rolling_total;

-- Breaking the layoffs down by company
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- Ranking the year with the highest layoffs
-- Version 1
WITH company_year (Company, Years, Total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
ORDER BY Ranking ASC;

-- Filtering the ranking with top 5 companies per year
-- Version 2
WITH company_year (Company, Years, Total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS 
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT * FROM Company_Year_Rank
WHERE Ranking <=5;