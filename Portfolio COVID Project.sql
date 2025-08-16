SELECT *
FROM [dbo].[CovidDeaths]
WHERE continent is not null;

--SELECT *
--FROM [dbo].[CovidVaccinations];

-- Select data that we are going to use
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM [dbo].[CovidDeaths]
WHERE continent is not null
ORDER BY 1,2;

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract Covid per country
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [dbo].[CovidDeaths]
WHERE Location LIKE '%states%'
ORDER BY 1,2;

-- Looking at Total Cases vs Population
--  Shows what percentage of the population got Covid
SELECT Location, date, population,total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM [dbo].[CovidDeaths]
WHERE Location LIKE '%states%' and continent is not null
ORDER BY 1,2;

-- Looking at Countries with Highest Infection Rate compared to population
SELECT Location,population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM [dbo].[CovidDeaths]
--WHERE Location LIKE '%states%'
WHERE continent is not null
GROUP BY Location, population
ORDER BY PercentPopulationInfected desc;



--This is showing the countries with highest death count per population.
SELECT Location, MAX(CAST(total_deaths as float)) as TotalDeathCount
FROM [dbo].[CovidDeaths]
--WHERE Location LIKE '%states%'
WHERE continent is not null
GROUP BY Location
ORDER BY TotalDeathCount desc;


--Let's break things down by continent
--Showing the continents with the highest death count per population.
SELECT continent, MAX(CAST(total_deaths as float)) as TotalDeathCount
FROM [dbo].[CovidDeaths]
--WHERE Location LIKE '%states%'
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc;

-- Global Numbers
SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as float)) as total_deaths, SUM(cast(new_deaths as float))/SUM(new_cases)*100 as DeathPercentage
FROM [dbo].[CovidDeaths]
--WHERE Location LIKE '%states%'
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

-- Global Numbers
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as float)) as total_deaths, SUM(cast(new_deaths as float))/SUM(new_cases)*100 as DeathPercentage
FROM [dbo].[CovidDeaths]
--WHERE Location LIKE '%states%'
WHERE continent is not null
--GROUP BY date
ORDER BY 1,2;


SELECT *
FROM [dbo].[CovidVaccinations];

SELECT *
FROM [dbo].[CovidDeaths];

--Use CTE

With PopvsVac(continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
-- Looking at total population vs vaccinations.
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(cast(vac.new_vaccinations as float))OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM [dbo].[CovidDeaths] dea
JOIN [dbo].[CovidVaccinations] vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY  2,3;
)
SELECT *, (RollingPeopleVaccinated/population)*100
FROM PopvsVac


--Temp Table


DROP TABLE IF exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric)

Insert INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(cast(vac.new_vaccinations as float))OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM [dbo].[CovidDeaths] dea
JOIN [dbo].[CovidVaccinations] vac
	ON dea.location = vac.location
	and dea.date = vac.date
--WHERE dea.continent is not null
--ORDER BY  2,3;

SELECT *, (RollingPeopleVaccinated/population)*100
FROM #PercentPopulationVaccinated


-- Creating View to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(cast(vac.new_vaccinations as float))OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM [dbo].[CovidDeaths] dea
JOIN [dbo].[CovidVaccinations] vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY  2,3;