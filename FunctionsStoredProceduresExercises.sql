--USE SoftUni

--CREATE OR ALTER PROC usp_GetEmployeesSalaryAbove35000
--AS
--	SELECT [FirstName], [LastName]
--		FROM Employees
--		WHERE Salary > 35000
--GO

--EXEC usp_GetEmployeesSalaryAbove35000



--CREATE OR ALTER PROC usp_GetEmployeesSalaryAboveNumber(@Number DECIMAL(18, 4))
--AS
--	SELECT [FirstName], [LastName]
--		FROM Employees
--		WHERE [Salary] >= @Number
--GO

--EXEC usp_GetEmployeesSalaryAboveNumber 48100



--CREATE OR ALTER PROC usp_GetTownsStartingWith(@FirstPart NVARCHAR(20))
--AS
--	DECLARE @SearchedPartLength INT = LEN(@FirstPart)
--	SELECT t.Name
--		FROM Towns t
--		WHERE LEFT(t.Name, @SearchedPartLength) = @FirstPart
--GO

--EXEC usp_GetTownsStartingWith 'b'




--CREATE OR ALTER PROC usp_GetEmployeesFromTown(@TownName NVARCHAR(50))
--AS
--	SELECT e.FirstName, e.LastName
--		FROM Employees e
--		LEFT JOIN Addresses a ON a.AddressID = e.AddressID
--		LEFT JOIN Towns t ON t.TownID = a.TownID
--		WHERE t.Name = @TownName
--GO

--EXEC usp_GetEmployeesFromTown 'Sofia'



--CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@Salary DECIMAL)
--RETURNS NVARCHAR(10)
--AS
--BEGIN
--	--DECLARE @Result NVARCHAR(10);
--	--IF (@Salary < 30000)
--	--	SET @Result = 'Low'
--	--ELSE IF (@Salary BETWEEN 30000 AND 50000)
--	--	SET @Result = 'Average'
--	--ELSE
--	--	SET @Result = 'High'

--	--RETURN @Result

--	RETURN CASE
--		WHEN @Salary < 30000 THEN 'Low'
--		WHEN @Salary BETWEEN 30000 AND 50000 THEN 'Average'
--		WHEN @Salary > 50000 THEN 'High'
--	END
--END

--SELECT Salary, dbo.ufn_GetSalaryLevel(Salary) AS [SalaryLevel]
--	FROM Employees



--CREATE OR ALTER PROC usp_EmployeesBySalaryLevel(@SalaryLevel NVARCHAR(10))
--AS
--	SELECT e.FirstName, e.LastName
--		FROM Employees e
--		WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @SalaryLevel
--GO

--EXEC usp_EmployeesBySalaryLevel 'High'



--CREATE OR ALTER FUNCTION ufn_IsWordComprised(@SetOfLetters NVARCHAR(MAX), @Word NVARCHAR(MAX))
--RETURNS BIT
--AS
--BEGIN
--	DECLARE @Index INT = 1
--	DECLARE @WordLength INT = LEN(@Word)
--	DECLARE @Result BIT = 1
--	WHILE (@Index <= @WordLength)
--	BEGIN
--		IF (CHARINDEX(SUBSTRING(@Word, @Index, 1), @SetOfLetters) = 0)
--		BEGIN
--			SET @Result = 0
--			BREAK
--		END

--		SET @Index += 1
--	END

--	RETURN @Result
--END

--SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')





--CREATE OR ALTER PROC usp_DeleteEmployeesFromDepartment(@DepartmentID INT)
--AS
--	ALTER TABLE Employees ALTER COLUMN DepartmentID INT NULL
--	ALTER TABLE Departments ALTER COLUMN ManagerID INT NULL

--	UPDATE Employees
--		SET [DepartmentID] = NULL
--		WHERE [DepartmentID] = @DepartmentID

--	UPDATE Departments
--		SET [ManagerID] = NULL
--		WHERE [DepartmentID] = @DepartmentID

--	SELECT COUNT(*)
--		FROM Employees
--		WHERE DepartmentID = @DepartmentID
--GO

--EXEC usp_DeleteEmployeesFromDepartment 1



-- using testing database from outside
--CREATE OR ALTER PROC usp_GetHoldersFullName
--AS
--	SELECT CONCAT(FirstName, ' ', LastName)
--		FROM AccountHolders
--GO





--CREATE OR ALTER PROC usp_GetHoldersWithBalanceHigherThan(@Balance MONEY)
--AS
--	SELECT ah.FirstName, ah.LastName
--		FROM AccountHolders ah
--		LEFT JOIN Accounts acc ON acc.AccountHolderId = ah.Id
--		GROUP BY ah.FirstName, ah.LastName
--		HAVING SUM(acc.Balance) >= @Balance
--		ORDER BY ah.FirstName, ah.LastName
--GO




--CREATE OR ALTER FUNCTION ufn_CalculateFutureValue(@Sum DECIMAL(18,4), @YearlyInterestRate FLOAT, @Years INT)
--RETURNS DECIMAL(18, 4)
--AS
--BEGIN
--	DECLARE @Result DECIMAL(18, 4) = 0
--	SET @Result = @Sum * (POWER(1 + @YearlyInterestRate, @Years))

--	RETURN @Result
--END

--SELECT dbo.ufn_CalculateFutureValue(1000.98, 0.05, 3)





--CREATE OR ALTER PROC usp_CalculateFutureValueForAccount(@AccountId INT, @YearlyInterestRate FLOAT)
--AS
--	SELECT
--			acc.Id AS [AccountId],
--			ah.FirstName, ah.LastName,
--			acc.Balance AS [CurrentBalance], 
--			dbo.ufn_CalculateFutureValue(acc.Balance, @YearlyInterestRate, 5) AS [BalanceIn5years]
--		FROM Accounts acc
--		LEFT JOIN AccountHolders ah ON ah.Id = acc.AccountHolderId
--		WHERE acc.Id = @AccountId
--GO





--USE Diablo
--GO

CREATE OR ALTER FUNCTION ufn_CashInUsersGames(@GameName NVARCHAR(50))
RETURNS TABLE AS
RETURN
(
	SELECT SUM(Res.Cash) AS [SumCash]
		FROM (
			SELECT g.Name, ug.Cash,
			ROW_NUMBER() OVER (PARTITION BY g.Name ORDER BY ug.Cash DESC) AS [Ranking]
			FROM Games g
			LEFT JOIN UsersGames ug ON ug.GameId = g.Id
			) AS Res
		WHERE res.Name = @GameName AND Res.Ranking % 2 = 1
		GROUP BY Res.Name
)

SELECT *
	FROM dbo.ufn_CashInUsersGames('Love in a mist')
	