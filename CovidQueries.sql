SELECT
date,
location,
total_cases,
total_deaths,
(total_deaths/total_cases)*100 AS 'Death Percentage'
FROM
dea 
WHERE 
date LIKE '%2022' AND location = 'United States'
ORDER BY 2,1

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM dea
WHERE date LIKE '%2022'
ORDER BY 1,2

--Looking at total cases vs total deaths 
--This shows likelihood of dying if you contract covid in United States this year 2022
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as 'Death Percentage'
FROM dea
WHERE location = 'United States' AND date LIKE '%2022'
ORDER BY 1,2

--Looking at total cases vs population
--This shows the amount of the population that was infected by covid in 2022
SELECT location,date,total_cases,population,(total_cases/population)*100 AS 'Population Infected'
FROM dea
WHERE date LIKE '%2022' AND location = 'United States'
ORDER BY 1,2

--Looking at countries with highest infection rate in 2022
SELECT location,MAX(total_cases),MAX((total_cases/population))*100 AS 'Population Infected'
FROM dea
WHERE date LIKE '%2022' continent is not null
GROUP BY location, population
ORDER BY 3 DESC 

-- This shows country with highest death count per population
SELECT location, MAX(CAST(total_deaths AS int)) as 'Total Death Count'
FROM dea
WHERE continent is not null
GROUP BY location
ORDER BY 2 DESC 

-- Looking at continent with highest death count 

SELECT continent, MAX(CAST(total_deaths AS int)) as 'Total Death Count'
FROM dea
WHERE continent is not null
GROUP BY continent
ORDER BY 2 DESC 

--Global numbers and Death Percentage

SELECT SUM(new_cases),SUM(new_deaths),(SUM(new_deaths)/SUM(new_cases))*100 AS 'Death Percentage'
FROM dea
WHERE continent is not NULL
--GROUP BY date
--ORDER BY 4 DESC

--Rolling People vaccinated 
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, SUM(CAST(v.new_vaccinations AS int)) OVER (partition by d.location order by d.location, d.date),v.total_vaccinations
FROM dea d 
JOIN vac v
ON d.location = v.location AND d.date = v.date
WHERE d.continent is not NULL
ORDER BY 2,3
