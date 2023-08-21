--USE SoftUni

--SELECT [FirstName], [LastName]
--	FROM Employees
--	WHERE LEFT([FirstName], 2) = 'SA'

--SELECT [FirstName], [LastName]
--	FROM Employees
--	WHERE [LastName] LIKE '%ei%'

--SELECT [FirstName], [LastName]
--	FROM Employees
--	WHERE CHARINDEX('ei', [LastName], 1) > 0

--SELECT [FirstName]
--	FROM Employees
--	WHERE ([DepartmentID] = 3 OR [DepartmentID] = 10)
--		AND (DATEPART(YEAR, [HireDate]) >= 1995 AND DATEPART(YEAR, [HireDate]) <= 2005)

--SELECT [FirstName], [LastName]
--	FROM Employees
--	WHERE [JobTitle] NOT LIKE '%engineer%'

--SELECT [Name]
--	FROM Towns
--	WHERE LEN([Name]) = 5 OR LEN([Name]) = 6
--	ORDER BY [Name]

--SELECT *
--	FROM Towns
--	WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
--	ORDER BY [Name]

--SELECT *
--	FROM Towns
--	WHERE LEFT([Name], 1) NOT IN ('R', 'B', 'D')
--	ORDER BY [Name]

--CREATE VIEW V_EmployeesHiredAfter2000 AS
--SELECT [FirstName], [LastName]
--	FROM Employees
--	WHERE DATEPART(YEAR, [HireDate]) > 2000

--SELECT [FirstName], [LastName]
--	FROM Employees
--	WHERE LEN([LastName]) = 5

--SELECT [EmployeeID], [FirstName], [LastName], [Salary], DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY [EmployeeID]) AS [Rank]
--	FROM Employees
--	WHERE [Salary] >= 10000 AND [Salary] <= 50000
--	ORDER BY [Salary] DESC

--SELECT *
--	FROM (SELECT [EmployeeID], [FirstName], [LastName], [Salary], DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY [EmployeeID]) AS [Rank]
--		FROM Employees
--		WHERE [Salary] >= 10000 AND [Salary] <= 50000) AS [Result]
--	WHERE Result.Rank = 2
--	ORDER BY [Salary] DESC




--USE Geography

--SELECT [CountryName], [IsoCode]
--	FROM Countries
--	WHERE LEN([CountryName]) - LEN(REPLACE([CountryName], 'A', '')) >= 3
--	ORDER BY [IsoCode]

--SELECT p.PeakName, r.RiverName, LOWER(CONCAT(SUBSTRING(p.PeakName, 1, LEN(p.PeakName) -1), r.RiverName)) AS Mix
--	FROM Peaks AS p
--	JOIN Rivers AS r ON RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
--	ORDER BY Mix




--USE Diablo

--SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS Start
--	FROM Games
--	WHERE DATEPART(YEAR, [Start]) IN (2011, 2012)
--	ORDER BY [Start], [Name]

--SELECT Username, SUBSTRING(Email, CHARINDEX('@', Email, 1) + 1, LEN(Email)) AS EmailProvider
--	FROM Users
--	ORDER BY EmailProvider, Username

--SELECT Username, IpAddress
--	FROM Users
--	WHERE IpAddress LIKE '___.1%.%.___'
--	ORDER BY Username

--SELECT Name AS Game,
--	CASE
--		WHEN DATEPART(HOUR, Start) >= 0 AND DATEPART(HOUR, START) < 12 THEN 'Morning'
--		WHEN DATEPART(HOUR, Start) >= 12 AND DATEPART(HOUR, START) < 18 THEN 'Afternoon'
--		WHEN DATEPART(HOUR, Start) >= 18 AND DATEPART(HOUR, START) < 24 THEN 'Evening'
--	END AS [Part of the Day],
--	CASE
--		WHEN Duration <= 3 THEN 'Extra Short'
--		WHEN Duration >= 4 AND Duration <= 6 THEN 'Short'
--		WHEN Duration > 6 THEN 'Long'
--		ELSE 'Extra Long'
--	END AS Duration
--	FROM Games
--	ORDER BY Game, Duration, [Part of the Day]




---- Build in Database in the judge system
--SELECT ProductName, OrderDate, DATEADD(DAY, 3, OrderDate) AS PayDue, DATEADD(MONTH, 1, OrderDate) AS DeliverDue
--	FROM Orders

