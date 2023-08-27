--USE Gringotts

--SELECT COUNT(*) AS Count
--	FROM WizzardDeposits

--SELECT MAX([MagicWandSize]) AS LongestMagicWand
--	FROM WizzardDeposits

--SELECT [DepositGroup], MAX(w.MagicWandSize) AS [LongestMagicWand]
--	FROM WizzardDeposits w
--	GROUP BY w.DepositGroup

--SELECT TOP(2) [DepositGroup]
--	FROM WizzardDeposits w
--	GROUP BY w.DepositGroup
--	ORDER BY AVG(w.MagicWandSize)

--SELECT w.DepositGroup, SUM(w.DepositAmount) AS [TotalSum]
--	FROM WizzardDeposits w
--	GROUP BY w.DepositGroup

--SELECT w.DepositGroup, SUM(w.DepositAmount) AS [TotalSum]
--	FROM WizzardDeposits w
--	WHERE w.MagicWandCreator = 'Ollivander family'
--	GROUP BY w.DepositGroup

--SELECT w.DepositGroup, SUM(w.DepositAmount) AS [TotalSum]
--	FROM WizzardDeposits w
--	WHERE w.MagicWandCreator = 'Ollivander family'
--	GROUP BY w.DepositGroup
--	HAVING SUM(w.DepositAmount) < 150000
--	ORDER BY [TotalSum] DESC

--SELECT w.DepositGroup, w.MagicWandCreator, MIN(w.DepositCharge) AS [MinDepositCharge]
--	FROM WizzardDeposits AS w
--	GROUP BY w.DepositGroup, w.MagicWandCreator
--	ORDER BY w.MagicWandCreator, w.DepositGroup

--SELECT grp.Range AS [AgeGroup], COUNT(*) AS [WizardCount]
--	FROM
--	(SELECT
--		CASE
--			WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
--			WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
--			WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
--			WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
--			WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
--			WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
--			ELSE '[61+]'
--		END AS [Range]
--		FROM WizzardDeposits AS w
--	) AS grp
--GROUP BY grp.Range

--SELECT LEFT(w.FirstName, 1) AS [FirstLetter]
--	FROM WizzardDeposits w
--	WHERE w.DepositGroup = 'Troll Chest'
--	GROUP BY LEFT(w.FirstName, 1)
--	ORDER BY [FirstLetter]

--SELECT w.DepositGroup, w.IsDepositExpired, AVG(w.DepositInterest) AS [AverageInterest]
--	FROM WizzardDeposits w
--	WHERE w.DepositStartDate > CAST('01/01/1985' AS DATE)
--	GROUP BY w.DepositGroup, w.IsDepositExpired
--	ORDER BY w.DepositGroup DESC, w.IsDepositExpired ASC

--SELECT SUM(res.Difference) AS [SumDifference]
--	FROM
--	(SELECT w.FirstName,
--		w.DepositAmount,
--		LEAD(w.FirstName, 1) OVER (ORDER BY w.Id) AS [GuestWizard],
--		LEAD(w.DepositAmount, 1) OVER (ORDER BY w.Id) AS [GuestWizardDeposit],
--		(w.DepositAmount - LEAD(w.DepositAmount, 1) OVER (ORDER BY w.Id)) AS [Difference]
--		FROM WizzardDeposits w) AS res
--	WHERE res.GuestWizard IS NOT NULL

--USE SoftUni

--SELECT e.DepartmentID, SUM(e.Salary) AS [TotalSalary]
--	FROM Employees e
--	GROUP BY e.DepartmentID
--	ORDER BY e.DepartmentID

--SELECT e.DepartmentID, MIN(e.Salary) AS [MinimumSalary]
--	FROM Employees e
--	WHERE e.HireDate > '2000-01-01' AND e.DepartmentID IN (2, 5, 7)
--	GROUP BY e.DepartmentID

----------

--CREATE TABLE #TempEmployees
--(
--	EmployeeID INT PRIMARY KEY,
--	FirstName VARCHAR(50) NOT NULL,
--	LastName VARCHAR(50) NOT NULL,
--	MiddleName VARCHAR(50) NULL,
--	JobTitle VARCHAR(50) NOT NULL,
--	DepartmentID INT NOT NULL,
--	ManagerID INT NULL,
--	HireDate SMALLDATETIME NOT NULL,
--	Salary MONEY NOT NULL,
--	AddressID INT NULL
--)

--INSERT INTO #TempEmployees
--SELECT *
--	FROM Employees e
--	WHERE e.Salary > 30000

--DELETE FROM #TempEmployees WHERE ManagerID = 42

--UPDATE #TempEmployees
--	SET [Salary] = [Salary] + 5000
--	WHERE DepartmentID = 1

--SELECT te.DepartmentID, AVG(te.Salary) AS [AverageSalary]
--	FROM #TempEmployees AS te
--	GROUP BY te.DepartmentID

------------

--SELECT e.DepartmentID, MAX(e.Salary) AS [MaxSalary]
--	FROM Employees e
--	GROUP BY e.DepartmentID
--	HAVING MAX(e.Salary) NOT BETWEEN 30000 AND 70000

--SELECT COUNT(*) AS [Count]
--	FROM Employees e
--	WHERE e.ManagerID IS NULL

--WITH DepartmentsSalaries_CTE (DepartmentID, Salary, Ranking) AS
--(
--SELECT e.DepartmentID, e.Salary,
--	DENSE_RANK() OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS [Ranking]
--	FROM Employees e
--)

--SELECT d.DepartmentID, MAX(d.Salary) AS [ThirdHighestSalary]
--	FROM DepartmentsSalaries_CTE d
--	WHERE d.Ranking = 3
--	GROUP BY d.DepartmentID

WITH DepartmentAVGSalaries_CTE (DepartmentID, AverageSalary) AS
(
SELECT e.DepartmentID, AVG(e.Salary) AS [AvarageSalary]
	FROM Employees e
	GROUP BY e.DepartmentID
)

SELECT TOP(10) em.FirstName, em.LastName, em.DepartmentID
	FROM Employees em
	LEFT JOIN DepartmentAVGSalaries_CTE AS dep ON dep.DepartmentID = em.DepartmentID
	WHERE em.Salary > dep.AverageSalary
	ORDER BY em.DepartmentID