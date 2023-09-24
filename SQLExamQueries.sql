CREATE DATABASE Bitbucket
GO

USE Bitbucket
GO

CREATE TABLE [Users]
(
	Id INT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(30) NOT NULL,
	Email VARCHAR(50) NOT NULL
)

CREATE TABLE Repositories
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE RepositoriesContributors
(
	RepositoryId INT NOT NULL,
	ContributorId INT NOT NULL,
	PRIMARY KEY(RepositoryId, ContributorId),
	CONSTRAINT FK_RepositoriesContributors_Repositories FOREIGN KEY (RepositoryId) REFERENCES Repositories(Id),
	CONSTRAINT FK_RepositoriesContributors_Users FOREIGN KEY (ContributorId) REFERENCES Users(Id)
)

CREATE TABLE Issues
(
	Id INT PRIMARY KEY IDENTITY,
	Title VARCHAR(255) NOT NULL,
	IssueStatus VARCHAR(6) NOT NULL,
	RepositoryId INT NOT NULL REFERENCES Repositories(Id),
	AssigneeId INT NOT NULL REFERENCES Users(Id)
)

CREATE TABLE Commits
(
	Id INT PRIMARY KEY IDENTITY,
	[Message] VARCHAR(255) NOT NULL,
	IssueId INT REFERENCES Issues(Id),
	RepositoryId INT NOT NULL REFERENCES Repositories(Id),
	ContributorId INT NOT NULL REFERENCES Users(Id)
)

CREATE TABLE Files
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(100) NOT NULL,
	Size DECIMAL(18, 2) NOT NULL,
	ParentId INT REFERENCES Files(Id),
	CommitId INT NOT NULL REFERENCES Commits(Id)
)

--Before you start, you must import "DataSet-Bitbucket.sql".
--If you have created the structure correctly, the data should be successfully inserted without any errors.

--INSERT INTO Files([Name], Size, ParentId, CommitId) VALUES
--('Trade.idk', 2598.0, 1, 1),
--('menu.net', 9238.31, 2, 2),
--('Administrate.soshy', 1246.93, 3, 3),
--('Controller.php', 7353.15, 4, 4),
--('Find.java', 9957.86, 5, 5),
--('Controller.json', 14034.87, 3, 6),
--('Operate.xix', 7662.92, 7, 7)

--INSERT INTO Issues(Title, IssueStatus, RepositoryId, AssigneeId) VALUES
--('Critical Problem with HomeController.cs file', 'open', 1, 4),
--('Typo fix in Judge.html', 'open', 4, 3),
--('Implement documentation for UsersService.cs', 'closed', 8, 2),
--('Unreachable code in Index.cs', 'open', 9, 8)


--Make issue status 'closed' where Assignee Id is 6.

--UPDATE [Issues]
--	SET [IssueStatus] = 'closed'
--	WHERE [AssigneeId] = 6


--Delete repository "Softuni-Teamwork" in repository contributors and issues.

--DECLARE @RepoIdToDelete INT = (SELECT [Id] FROM [Repositories] WHERE [Name] = 'Softuni-Teamwork')
--DELETE FROM [Issues] WHERE [RepositoryId] = @RepoIdToDelete
--DELETE FROM [Files] WHERE [CommitId] IN (SELECT [Id] FROM [Commits] WHERE [RepositoryId] = @RepoIdToDelete)
--DELETE FROM [Commits] WHERE [RepositoryId] = @RepoIdToDelete
--DELETE FROM [RepositoriesContributors] WHERE [RepositoryId] = @RepoIdToDelete
--DELETE FROM [Repositories] WHERE [Id] = @RepoIdToDelete


--*You need to start with a fresh dataset, so recreate your DB and import the sample data again ("DataSet-Bitbucket.sql").

--Select all commits from the database. Order them by id (ascending), message (ascending), repository id (ascending) and contributor id (ascending).
--SELECT Id, [Message], RepositoryId, ContributorId
--	FROM Commits
--	ORDER BY Id, [Message], RepositoryId, ContributorId


--Select all of the files, which have size, greater than 1000, and a name containing "html".
--Order them by size (descending), id (ascending) and by file name (ascending).
--SELECT [Id], [Name], [Size]
--	FROM [Files]
--	WHERE [Size] > 1000 AND [Name] LIKE '%html'
--	ORDER BY [Size] DESC, [Id], [Name]


--Select all of the issues, and the users that are assigned to them,
--so that they end up in the following format: {username} : {issueTitle}.
--Order them by issue id (descending) and issue assignee (ascending).
--SELECT i.Id, u.Username + ' : ' + i.Title AS [IssueAssignee]
--	FROM Issues i
--	LEFT JOIN Users u ON i.AssigneeId = u.Id
--	ORDER BY i.Id DESC, i.AssigneeId


--Select all of the files, which are NOT a parent to any other file.
--Select their size of the file and add "KB" to the end of it.
--Order them file id (ascending), file name (ascending) and file size (descending).
--SELECT [Id], [Name], CONVERT(VARCHAR, [Size]) + 'KB' AS [Size]
--	FROM [Files] AS f
--	WHERE [Id] NOT IN (SELECT fi.ParentId FROM [Files] fi WHERE fi.ParentId IS NOT NULL)
--	ORDER BY [Id]


--Select the top 5 repositories in terms of count of commits.
--Order them by commits count (descending), repository id (ascending) then by repository name (ascending).
--P.S. Original task description is wrong - there is no reason to have to count contributors to repositories
--SELECT TOP(5) r.Id, r.Name, COUNT(*) AS [Commits]
--	FROM [Repositories] AS r
--	LEFT JOIN [Commits] AS c ON c.RepositoryId = r.Id
--	LEFT JOIN [RepositoriesContributors] AS rc ON rc.RepositoryId = r.Id
--	GROUP BY r.Id, r.Name
--	ORDER BY COUNT(*) DESC, r.Id, r.Name



--Select all users which have commits.
--Select their username and average size of the file, which were uploaded by them.
--Order the results by average upload size (descending) and by username (ascending).
--SELECT u.Username, AVG(f.Size) AS [Size]
--	From [Commits] AS c
--	LEFT JOIN [Users] AS u ON c.ContributorId = u.Id
--	JOIN [Files] AS f ON f.CommitId = c.Id
--	GROUP BY u.Username
--	ORDER BY AVG(f.Size) DESC, u.Username

--Create a user defined function, named udf_AllUserCommits(@username) that receives a username.
--The function must return count of all commits for the user.

--CREATE OR ALTER FUNCTION udf_AllUserCommits(@Username VARCHAR(MAX))
--RETURNS INT
--AS
--BEGIN
--	DECLARE @Result INT = (SELECT COUNT(*)
--		FROM Users u
--		JOIN Commits c ON c.ContributorId = u.Id
--		WHERE u.Username = @Username)
--	RETURN @Result
--END

--SELECT dbo.udf_AllUserCommits('UnderSinduxrein')


--Create a user defined stored procedure, named usp_SearchForFiles(@fileExtension), that receives files extensions.
--The procedure must print the id, name and size of the file.
--Add "KB" in the end of the size. Order them by id (ascending), file name (ascending) and file size (descending).

CREATE OR ALTER PROC usp_SearchForFiles(@FileExtension VARCHAR(MAX))
AS
	SELECT f.Id, f.Name, CONVERT(VARCHAR, f.Size) + 'KB' AS [Size]
		FROM [Files] AS f
		WHERE f.Name LIKE '%.' + @FileExtension
		ORDER BY f.Id
GO

EXEC usp_SearchForFiles 'txt'