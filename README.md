🔗 [View the MySQL Project File](https://github.com/AfeezTheAnalyst/EDA_World_Layoffs_Data/blob/main/EDA_World_Layoffs_Data.sql)
# 🌍 Global Layoffs Analysis (EDA with MySQL)

## 📌 Project Overview
This project presents an in-depth **Exploratory Data Analysis (EDA)** of global layoffs using **MySQL**. The objective is to uncover key trends, patterns, and insights surrounding workforce reductions across companies, industries, and countries.

The dataset used in this analysis was pre-cleaned in a prior phase:  
🔗 [Data Cleaning Project](https://github.com/AfeezTheAnalyst/Data-Cleaning-Project-with-SQL)

This phase focuses entirely on **data exploration and insight generation using SQL**.

---

## 🎯 Problem Statement
Layoffs have significantly impacted companies worldwide, but key questions remain:

- Which companies and industries are most affected?  
- When did layoffs peak?  
- How do layoffs vary across regions?  

This project answers these questions using **structured SQL analysis**.

---

## 🛠️ Tools & Technologies
- MySQL  
- SQL Window Functions (`DENSE_RANK`, `SUM() OVER`)  
- Common Table Expressions (CTEs)  
- Aggregate Functions  

---

## 🔍 Key Analysis Performed

### 📊 Dataset Overview
```sql
SELECT *
FROM layoffs_staging2;
```

## 🏢 Company-Level Analysis
Identified companies with the highest layoffs
Analyzed companies with 100% workforce layoffs
Compared layoffs against funding raised
```sql
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
```

## 🏭 Industry Analysis
Ranked industries by total layoffs
Highlighted the most affected sectors
```sql
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
```

## 🌎 Geographic Analysis
Ranked countries by layoffs
Identified the most impacted regions
```sql
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
```

## 📈 Monthly Trends & Rolling Total
Calculated monthly layoffs
Built cumulative running totals
```sql
WITH Rolling_total AS
(
SELECT SUBSTRING(`date`, 1,7) AS MONTH, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
GROUP BY MONTH
)
SELECT MONTH, total_off,
SUM(total_off) OVER (ORDER BY MONTH) AS running_total
FROM Rolling_total;
```

## 🏆 Advanced Analysis (Ranking)
Ranked companies by layoffs per year
Extracted the top 5 companies per year
```sql
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC)
```

## 💡 Key Insights
- Some companies experienced complete layoffs (100%), indicating shutdowns  
- Certain industries consistently recorded the highest layoffs  
- Layoffs peaked during specific periods, reflecting economic trends  
- A few countries were disproportionately affected  
- High funding levels did not always prevent layoffs  

## 🚀 Skills Demonstrated
- Advanced SQL querying  
- Use of CTEs for structured analysis  
- Application of window functions  
- Time-series analysis in SQL  
- Data aggregation and trend identification  
- Analytical problem-solving  

## 📊 Project Value
This project demonstrates how SQL can be used for:

- Data exploration  
- Business insight generation  
- Trend analysis  
- Decision support  

## 📝 Professional Summary

Data enthusiast with hands-on experience in SQL-driven data analysis, specializing in exploratory data analysis (EDA) of real-world datasets. Leveraging MySQL, I performed advanced queries, time-series analysis, and ranking to extract actionable insights from global layoffs data.

Skilled in:

Writing complex SQL queries with aggregate functions and joins
Utilizing CTEs and window functions for structured analysis
Performing trend analysis across companies, industries, countries, and time periods
Translating raw data into meaningful business insights

This project demonstrates my ability to analyze large datasets, identify patterns, and communicate insights effectively, providing decision-makers with the information needed to understand workforce trends and business impacts.
