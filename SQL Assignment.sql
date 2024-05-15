
 SELECT * 
  FROM [assignment].[dbo].[Corona_Virus_Dataset];

-- Q1. Write a code to check NULL values
SELECT *
FROM Corona_Virus_Dataset
WHERE Province IS  NULL OR  Country_Region IS  NULL OR Latitude IS  NULL OR Longitude IS  NULL OR Date IS  NULL OR 
Confirmed IS  NULL OR Deaths IS  NULL OR Recovered IS  NULL;


--QSTN2 Code to fill in blanks with zeros
UPDATE Corona_Virus_Dataset
SET Province = ISNULL(Province, 0),
    Country_Region = ISNULL(Country_Region, 0),
    Latitude = ISNULL(Latitude, 0),
    Longitude = ISNULL(Longitude, 0),
    Confirmed= ISNULL(Confirmed, 0),
    Deaths = ISNULL(Deaths, 0),
    Recovered = ISNULL(Recovered, 0)
   
WHERE Province IS NULL OR Country_Region IS NULL OR Latitude IS NULL OR Longitude IS NULL OR Date IS NULL OR Deaths IS NULL OR 
Recovered IS NULL;


-- Q3. checking total number of rows
SELECT COUNT(*) AS row_count
FROM Corona_Virus_Dataset;


-- Q4. Check what is start_date and end_date




SELECT MIN(Date) AS start_date,
MAX(Date) AS end_date
FROM Corona_Virus_Dataset;



-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT CONCAT(YEAR(Date), '-', MONTH(Date))) AS num_months
FROM Corona_Virus_Dataset;









-- Q6. Find monthly average for confirmed, deaths, recovered

SELECT 
    CONCAT(YEAR(Date), '-', MONTH(Date)) AS month,
    AVG(Confirmed) AS avg_confirmed,
    AVG(Deaths) AS avg_deaths,
    AVG(Recovered) AS avg_recovered
FROM 
    Corona_Virus_Dataset
GROUP BY 
    YEAR(Date), MONTH(Date);



-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT 
    CONCAT(YEAR(Date), '-', MONTH(Date)) AS month,
    (SELECT TOP 1 Confirmed
     FROM Corona_Virus_Dataset t2
     WHERE YEAR(t2.Date) = YEAR(Corona_Virus_Dataset.Date)
       AND MONTH(t2.Date) = MONTH(Corona_Virus_Dataset.Date)
     GROUP BY Confirmed
     ORDER BY COUNT(*) DESC) AS most_frequent_confirmed,
    (SELECT TOP 1 Deaths
     FROM Corona_Virus_Dataset t3
     WHERE YEAR(t3.Date) = YEAR(Corona_Virus_Dataset.Date)
       AND MONTH(t3.Date) = MONTH(Corona_Virus_Dataset.Date)
     GROUP BY Deaths
     ORDER BY COUNT(*) DESC) AS most_frequent_deaths,
    (SELECT TOP 1 Recovered
     FROM Corona_Virus_Dataset t4
     WHERE YEAR(t4.Date) = YEAR(Corona_Virus_Dataset.Date)
       AND MONTH(t4.Date) = MONTH(Corona_Virus_Dataset.Date)
     GROUP BY Recovered
     ORDER BY COUNT(*) DESC) AS most_frequent_recovered
FROM 
    Corona_Virus_Dataset
GROUP BY 
    YEAR(Date), MONTH(Date);


-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM 
    Corona_Virus_Dataset
GROUP BY 
    YEAR(DATE);

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM 
    Corona_Virus_Dataset
GROUP BY 
    YEAR(Date);

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT 
    CONCAT(YEAR(Date), '-', MONTH(Date)) AS month,
    SUM(Confirmed) AS total_confirmed,
    SUM(Deaths) AS total_deaths,
    SUM(Recovered) AS total_recovered
FROM 
    Corona_Virus_Dataset
GROUP BY 
    YEAR(Date), MONTH(Date);


-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total confirmed cases
SELECT 
    SUM(Confirmed) AS total_confirmed_cases
FROM 
    Corona_Virus_Dataset;

-- Calculate average confirmed cases
SELECT 
    AVG(Confirmed) AS average_confirmed_cases
FROM 
    Corona_Virus_Dataset;

-- Calculate variance of confirmed cases
SELECT 
    VAR(Confirmed) AS variance_confirmed_cases
FROM 
    Corona_Virus_Dataset;

-- Calculate standard deviation of confirmed cases
SELECT 
    STDEV(Confirmed) AS stdev_confirmed_cases
FROM 
    Corona_Virus_Dataset;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total Deaths cases
SELECT 
    SUM(Deaths) AS total_deaths_cases
FROM 
    Corona_Virus_Dataset;

-- Calculate average Deaths cases
SELECT 
    AVG(Deaths) AS average_deaths_cases
FROM 
    Corona_Virus_Dataset;

-- Calculate variance of deaths cases
SELECT 
    VAR(Deaths) AS variance_deaths_cases
FROM 
    Corona_Virus_Dataset;

-- Calculate standard deviation of confirmed cases
SELECT 
    STDEV(Deaths) AS stdev_deaths_cases
FROM 
    Corona_Virus_Dataset;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total recovered cases
SELECT 
    SUM(Recovered) AS total_recovered
	
FROM 
    Corona_Virus_Dataset;

-- Calculate average recovered cases
SELECT 
    AVG(Recovered) AS average_recovered_cases
FROM 
    Corona_Virus_Dataset;
	
-- Calculate variance of recovered cases
SELECT 
    VAR(Recovered) AS variance_recovered_cases
FROM 
    Corona_Virus_Dataset;

-- Calculate standard deviation of recovered cases
SELECT 
    STDEV(Recovered) AS stdev_recovered_cases
FROM 
    Corona_Virus_Dataset;

-- Q14. Find Country having highest number of the Confirmed case
SELECT Country_Region
FROM Corona_Virus_Dataset
WHERE Confirmed = (SELECT MAX(Confirmed) FROM Corona_Virus_Dataset);



-- Q15. Find Country having lowest number of the death case
SELECT Country_Region
FROM Corona_Virus_Dataset
WHERE Deaths = (SELECT MIN(Deaths) FROM Corona_Virus_Dataset);




-- Q16. Find top 5 countries having highest recovered case
SELECT TOP 5 Country_Region, SUM(Recovered) AS TotalRecovered
FROM Corona_Virus_Dataset
GROUP BY Country_Region
ORDER BY TotalRecovered DESC;




