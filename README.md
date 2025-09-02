# Covid-19 Data Exploration Portfolio Project #

## Project Overview ##
This project is a comprehensive data analysis of global Covid-19 data. The primary goal was to explore the impact of the pandemic by analyzing key metrics such as infection rates, death percentages, and vaccination progress across various countries and continents. The analysis was performed using SQL, and the resulting insights are foundational for a business intelligence or data analytics dashboard.

**Data Source**
The data used in this project was sourced from public data provided by Our World in Data and Johns Hopkins University. The dataset contains information on Covid-19 cases, deaths, and vaccination numbers.

**Tools & Technologies**
SQL (T-SQL): Used for all data cleaning, transformation, and analysis.

Microsoft SQL Server Management Studio (SSMS): The environment where the queries were executed.
Power BI / Tableau (Intended): The final stage of this project would be to visualize these insights in a dashboard.

**SQL Queries**
All the SQL queries for this project are located in the covid_analysis.sql file. The queries are well-commented to explain each step, including:

Initial Data Selection: Importing and reviewing the raw data from two tables: CovidDeaths and CovidVaccinations.
Death and Infection Rate Analysis: Calculating the percentage of the population that was infected and the death percentage among those who contracted the virus, with a focus on specific countries.

Geographical Breakdown: Identifying the highest infection and death counts by country and continent.

Global Numbers: Aggregating data to see worldwide trends in total cases and deaths.

Population vs. Vaccinations: Using a Common Table Expression (CTE) and a temporary table to calculate the rolling percentage of the population that has been vaccinated over time.

View Creation: Creating a view to store a permanent query for future data visualization.

**Key Insights & Findings**
Death Percentage: The analysis provides a clear look at the percentage of total cases that result in death, broken down by country.
Population Infection Rate: The queries reveal the percentage of each country's population that has been infected with Covid-19, highlighting the highest infection rates globally.
Continental Impact: The data shows the total death count per continent, which provides a high-level view of the pandemic's impact on different regions.
Vaccination Progress: By calculating a rolling count of vaccinated individuals, the project demonstrates the gradual progress of vaccinations compared to the total population.

**How to Use This Repository**
To use this project, you can:

Clone this repository to your local machine.
Connect to a SQL database (e.g., SQL Server, MySQL, PostgreSQL).
Load the Covid-19 dataset into your database using the provided table schemas.
Execute the queries in covid_analysis.sql to replicate the analysis and view the results.
Feel free to explore the code, replicate the analysis, or provide suggestions for improvement.

License
This project is open-sourced under the MIT License.
