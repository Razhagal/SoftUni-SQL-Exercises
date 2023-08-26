--USE SoftUni

--SELECT TOP(5) e.EmployeeID, e.JobTitle, e.AddressID, a.AddressText
--	FROM Employees e
--	JOIN Addresses a ON e.AddressID = a.AddressID
--	ORDER BY e.AddressID

--SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name AS [DepartmentName]
--	FROM Employees e
--	JOIN Departments d ON e.DepartmentID = d.DepartmentID
--	WHERE d.Name = 'Sales'
--	ORDER BY e.EmployeeID

--SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.Name AS [DepartmentName]
--	FROM Employees e
--	JOIN Departments d ON e.DepartmentID = d.DepartmentID
--	WHERE e.Salary > 15000
--	ORDER BY d.DepartmentID

--SELECT TOP(3) e.EmployeeID, e.FirstName
--	FROM Employees e
--	LEFT JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
--	LEFT JOIN Projects p ON p.ProjectID = ep.ProjectID
--	WHERE p.ProjectID IS NULL
--	ORDER BY e.EmployeeID

--SELECT e.FirstName, e.LastName, e.HireDate, d.Name AS [DeptName]
--	FROM Employees e
--	JOIN Departments d ON d.DepartmentID = e.DepartmentID
--	WHERE e.HireDate > '1999-01-01' AND d.Name IN ('Sales', 'Finance')
--	ORDER BY e.HireDate

--SELECT TOP(5) e.EmployeeID, e.FirstName, p.Name AS [ProjectName]
--	FROM Employees e
--	LEFT JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
--	LEFT JOIN Projects p ON p.ProjectID = ep.ProjectID
--	WHERE p.StartDate > CAST('2002.08.13' AS SMALLDATETIME) AND p.EndDate IS NULL
--	ORDER BY e.EmployeeID

--SELECT e.EmployeeID, e.FirstName, 
--	CASE
--		WHEN DATEPART(YEAR, p.StartDate) >= 2005 THEN NULL
--		ELSE p.Name
--	END AS [ProjectName]
--	FROM Employees e
--	JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
--	JOIN Projects p ON p.ProjectID = ep.ProjectID
--	WHERE e.EmployeeID = 24

--SELECT e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName AS [ManagerName]
--	FROM Employees e
--	JOIN Employees m ON e.ManagerID = m.EmployeeID
--	WHERE e.ManagerID IN (3, 7)
--	ORDER BY e.EmployeeID

--SELECT TOP(50) e.EmployeeID,
--		CONCAT(e.FirstName, ' ', e.LastName) AS [EmployeeName],
--		CONCAT(em.FirstName, ' ', em.LastName) AS [ManagerName],
--		d.Name AS [DepartmentName]
--	FROM Employees e
--	LEFT JOIN Employees em ON em.EmployeeID = e.ManagerID
--	LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
--	ORDER BY e.EmployeeID

--SELECT TOP(1)
--	(SELECT AVG(e.Salary) FROM Employees e WHERE e.DepartmentID = d.DepartmentID) AS [MinAverageSalary]
--	FROM Departments d
--	ORDER BY [MinAverageSalary]

--SELECT TOP(1) AVG(e.Salary) AS [MinAverageSalary]
--	FROM Employees e
--	GROUP BY e.DepartmentID
--	ORDER BY [MinAverageSalary]

--SELECT MIN(a.MinAverageSalary) AS [MinAverageSalary]
--	FROM
--	(
--		SELECT AVG(e.Salary) AS [MinAverageSalary]
--		FROM Employees e
--		GROUP BY e.DepartmentID
--	) AS a

--USE Geography

--SELECT c.CountryCode, m.MountainRange, p.PeakName, p.Elevation
--	FROM Countries c
--	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
--	LEFT JOIN Mountains m ON m.Id = mc.MountainId
--	LEFT JOIN Peaks p ON p.MountainId = m.Id
--	WHERE c.CountryCode = 'BG' AND p.Elevation > 2835
--	ORDER BY p.Elevation DESC

--SELECT c.CountryCode,
--	(
--	SELECT COUNT(*)
--		FROM Mountains m
--		JOIN MountainsCountries mc ON mc.MountainId = m.Id
--		WHERE c.CountryCode = mc.CountryCode
--	) AS [MountainRanges]
--	FROM Countries c
--	WHERE c.CountryCode IN ('BG', 'US', 'RU')
--	ORDER BY c.CountryCode

--SELECT c.CountryCode, COUNT(*) AS [MountainRanges]
--	FROM Mountains m
--	JOIN MountainsCountries mc ON mc.MountainId = m.Id
--	JOIN Countries c ON c.CountryCode = mc.CountryCode
--	WHERE c.CountryCode IN ('BG', 'US', 'RU')
--	GROUP BY c.CountryCode
--	ORDER BY c.CountryCode

--SELECT TOP(5) c.CountryName, r.RiverName
--	FROM Countries c
--	LEFT JOIN Continents con ON con.ContinentCode = c.ContinentCode
--	LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
--	LEFT JOIN Rivers r ON r.id = cr.RiverId
--	WHERE con.ContinentName = 'Africa'
--	ORDER BY c.CountryName

--WITH Currencies_CTE (ContinentCode, CurrencyCode, CurrencyUsage, CurrencyUsageRank) AS
--(
--	SELECT c.ContinentCode, c.CurrencyCode, COUNT(c.CurrencyCode),
--			DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS CurrencyUsageRank
--		FROM Countries c
--		GROUP BY c.CurrencyCode, c.ContinentCode
--)
--SELECT c.ContinentCode, c.CurrencyCode, c.CurrencyUsage
--	FROM Currencies_CTE c
--	WHERE c.CurrencyUsage > 1 AND c.CurrencyUsageRank = 1
--	ORDER BY c.ContinentCode

--SELECT COUNT(*) AS [Count]
--	FROM Countries c
--	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
--	WHERE mc.CountryCode IS NULL

--SELECT TOP(5) c.CountryName,
--	(
--		SELECT MAX(p.Elevation)
--			FROM Peaks p
--			LEFT JOIN Mountains m ON m.Id = p.MountainId
--			LEFT JOIN MountainsCountries mc ON mc.MountainId = m.Id
--			WHERE mc.CountryCode = c.CountryCode
--	) AS [HighestPeakElevation],
--	(
--		SELECT MAX(r.Length)
--			FROM Rivers r
--			LEFT JOIN CountriesRivers cr ON cr.RiverId = r.Id
--			WHERE cr.CountryCode = c.CountryCode
--	) AS [LongestRiverLength]
--	FROM Countries c
--	ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, c.CountryName

--SELECT TOP(5) c.CountryName, MAX(p.Elevation) AS [HighestPeakElevation], MAX(r.Length) AS [LongestRiverLength]
--	FROM Countries c
--	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
--	LEFT JOIN Mountains m ON m.Id = mc.MountainId
--	LEFT JOIN Peaks p ON p.MountainId = m.Id
--	LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
--	LEFT JOIN Rivers r ON r.Id = cr.RiverId
--	GROUP BY c.CountryName
--	ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, c.CountryName

--SELECT c.CountryName, p.PeakName, p.Elevation, m.MountainRange
--	FROM Countries c
--	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
--	LEFT JOIN Mountains m ON m.Id = mc.MountainId
--	LEFT JOIN Peaks p ON p.MountainId = m.Id

WITH CountriesMountainsPeak_CTE (CountryName, PeakName, PeakElevation, MountainRange, Ranking) AS
(
SELECT c.CountryName, p.PeakName, p.Elevation, m.MountainRange,
	DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS Ranking
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains m ON m.Id = mc.MountainId
	LEFT JOIN Peaks p ON p.MountainId = m.Id
)

SELECT TOP(5) c.CountryName AS [Country],
		ISNULL(c.PeakName, '(no highest peak)') AS [HighestPeakName],
		ISNULL(MAX(c.PeakElevation), 0) AS [HighestPeakElevation],
		CASE
			WHEN c.PeakName IS NOT NULL THEN c.MountainRange
			ELSE '(no mountain)'
		END AS [Mountain]
	FROM CountriesMountainsPeak_CTE c
	WHERE c.Ranking = 1
	GROUP BY c.CountryName, c.PeakName, c.MountainRange
	ORDER BY c.CountryName, [HighestPeakName]