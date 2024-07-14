Project Overview 
This project delved into the factors influencing global life expectancy over the past 15 years. By employing MySQL for data cleaning and exploration, I sought to uncover patterns and correlations between life expectancy and key variables such as GDP, BMI, and country development status.

Data Cleaning Process 
- Scrutinized the Dataset: Employed SELECT statements to uncover data characteristics, inconsistencies, and potential anomalies.
- Eliminated Duplicates: Removed redundant records using GROUP BY, HAVING, and ROW_NUMBER() window functions to pinpoint and remove exact matches.
- Imputed Missing Values: Filled data gaps leveraging UPDATE statements and JOIN operations based on logical relationships and domain knowledge.
- Harmonized Data Format: Enforced consistency by standardizing data types, units, and character formats through targeted UPDATE statements.

Exploratory Data Analysis -
- Unveiled Life Expectancy Trends: Dissected life expectancy patterns across countries and years, calculating minimum, maximum, and average values using MIN, MAX, AVG, GROUP BY, and HAVING functions.
- Examined GDP Impact: Investigated the correlation between GDP and life expectancy by employing INNER JOIN and GROUP BY statements to identify potential relationships.
- Contrasting Development Status: Compared life expectancy variations between developed and developing countries using GROUP BY and AVG clauses to uncover disparities.
- Analyzed BMI Influence: Explored the connection between BMI and life expectancy through AVG, GROUP BY, and ORDER BY functions to identify potential trends.

Challenges
- Navigating Data Quality Pitfalls: Encountered significant hurdles due to numerous zero values in the life expectancy column, necessitating meticulous data handling to prevent skewed findings.
- Addressing Data Gaps: Faced challenges accurately imputing missing values, particularly within the critical life expectancy variable.
- Overcoming Update Constraints: Initial attempts to efficiently modify the 'Status' column were hindered by subquery limitations.

Insights
- Harnessing Self-Joins: Discovered the power of self-joins for effectively updating and imputing missing data based on related records.
- Uncovering Economic Impact: Observed a strong correlation between GDP and life expectancy, emphasizing the pivotal role of economic factors in population health.
- Recognizing the Power of Visualization: Realized the indispensable nature of visual tools like Tableau for uncovering hidden patterns and effectively communicating findings.

Key Findings and Recommendations
- Economic Prosperity and Longevity: Higher GDP nations generally exhibit greater life expectancy, highlighting the socioeconomic determinants of health.
- Development Disparities: Developed countries demonstrate significantly higher life expectancies compared to their developing counterparts.
- Prioritizing Data Quality: Addressing data quality issues, such as zero values and missing data, is paramount for robust analysis and reliable conclusions.
