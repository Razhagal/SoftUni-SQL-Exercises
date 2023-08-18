--CREATE DATABASE TableRelations

--USE TableRelations

--IF OBJECT_ID('Persons') IS NOT NULL
--	DROP TABLE Persons
--IF OBJECT_ID('Passports') IS NOT NULL
--	DROP TABLE Passports
--IF OBJECT_ID('Models') IS NOT NULL
--	DROP TABLE Models
--IF OBJECT_ID('Manufacturers') IS NOT NULL
--	DROP TABLE Manufacturers
--IF OBJECT_ID('Students') IS NOT NULL
--	DROP TABLE Students
--IF OBJECT_ID('Exams') IS NOT NULL
--	DROP TABLE Exams
--IF OBJECT_ID('StudentsExams') IS NOT NULL
--	DROP TABLE StudentsExams
--IF OBJECT_ID('Teachers') IS NOT NULL
--	DROP TABLE Teachers

--CREATE TABLE Persons(
--	PersonID INT IDENTITY,
--	FirstName NVARCHAR(50) NOT NULL,
--	Salary DECIMAL NOT NULL,
--	PassportID INT UNIQUE NOT NULL
--)

--CREATE TABLE Passports(
--	PassportID INT IDENTITY(101, 1) PRIMARY KEY,
--	PassportNumber nvarchar(50) UNIQUE NOT NULL
--)

--INSERT INTO Persons (FirstName, Salary, PassportID) VALUES
--(N'Roberto', 43300, 102),
--(N'Tom', 56100, 103),
--(N'Yana', 60200, 101)

--INSERT INTO Passports (PassportNumber) VALUES
--(N'N34FG21B'),
--(N'K65LO4R7'),
--(N'ZE657QP2')

--ALTER TABLE Persons
--ADD CONSTRAINT PK_Person PRIMARY KEY (PersonID)

--ALTER TABLE Persons
--ADD CONSTRAINT FK_Persons_Passports FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)

--CREATE TABLE Manufacturers(
--	ManufacturerID INT IDENTITY PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL,
--	EstablishedOn SMALLDATETIME NOT NULL
--)

--CREATE TABLE Models(
--	ModelID INT IDENTITY(101, 1) PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL,
--	ManufacturerID INT,
--	CONSTRAINT FK_Models_Manufacturers FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
--)

--INSERT INTO Manufacturers (Name, EstablishedOn) VALUES
--(N'BMW', '07/03/1916'),
--(N'Tesla', '01/01/2003'),
--(N'Lada', '01/05/1966')

--INSERT INTO Models (Name, ManufacturerID) VALUES
--(N'X1', 1),
--(N'i6', 1),
--(N'Model S', 2),
--(N'Model X', 2),
--(N'Model 3', 2),
--(N'Nova', 3)

--CREATE TABLE Students(
--	StudentID INT IDENTITY PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL
--)

--CREATE TABLE Exams(
--	ExamID INT IDENTITY(101, 1) PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL
--)

--CREATE TABLE StudentsExams(
--	StudentID INT,
--	ExamID INT,
--	CONSTRAINT PK_StudentsExams PRIMARY KEY(StudentID, ExamID),
--	CONSTRAINT FK_StudentsExams_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
--	CONSTRAINT FK_StudentsExams_Exams FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
--)

--INSERT INTO Students (Name) VALUES
--(N'Mila'),
--(N'Toni'),
--(N'Ron')

--INSERT INTO Exams (Name) VALUES
--(N'SpringMVC'),
--(N'Neo4j'),
--(N'Oracle 11g')

--INSERT INTO StudentsExams (StudentID, ExamID) VALUES
--(1, 101),
--(1, 102),
--(2, 101),
--(3, 103),
--(2, 102),
--(2, 103)

--CREATE TABLE Teachers(
--	TeacherID INT IDENTITY(101, 1) PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL,
--	ManagerID INT,
--	CONSTRAINT FK_Teachers_Teachers FOREIGN KEY (ManagerID) REFERENCES Teachers(TeacherID)
--)

--INSERT INTO Teachers (Name, ManagerID) VALUES
--(N'John', NULL),
--(N'Maya', 106),
--(N'Silvia', 106),
--(N'Ted', 105),
--(N'Mark', 101),
--(N'Greta', 101)

--CREATE DATABASE OnlineStore
--GO

--USE OnlineStore

--IF OBJECT_ID('Cities') IS NOT NULL
--	DROP TABLE Cities
--IF OBJECT_ID('Customers') IS NOT NULL
--	DROP TABLE Customers
--IF OBJECT_ID('Orders') IS NOT NULL
--	DROP TABLE Orders
--IF OBJECT_ID('ItemTypes') IS NOT NULL
--	DROP TABLE ItemTypes
--IF OBJECT_ID('Items') IS NOT NULL
--	DROP TABLE Items
--IF OBJECT_ID('OrderItems') IS NOT NULL
--	DROP TABLE OrderItems

--CREATE TABLE Cities(
--	CityID INT IDENTITY PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL
--)

--CREATE TABLE Customers(
--	CustomerID INT IDENTITY PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL,
--	Birthday DATE NOT NULL,
--	CityID INT,
--	CONSTRAINT FK_Customers_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID)
--)

--CREATE TABLE Orders(
--	OrderID INT IDENTITY PRIMARY KEY,
--	CustomerID INT NOT NULL,
--	CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
--)

--CREATE TABLE ItemTypes (
--	ItemTypeID INT IDENTITY PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL
--)

--CREATE Table Items (
--	ItemID INT IDENTITY PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL,
--	ItemTypeID INT NOT NULL,
--	CONSTRAINT FK_Items_ItemTypes FOREIGN KEY (ItemTypeID) REFERENCES ItemTypes(ItemTypeID)
--)

--CREATE TABLE OrderItems(
--	OrderID INT,
--	ItemID INT,
--	CONSTRAINT PK_OrderItems PRIMARY KEY(OrderID, ItemID),
--	CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
--	CONSTRAINT FK_OrderItems_ItemID FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
--)

--CREATE DATABASE University
--GO

--USE University

--IF OBJECT_ID('Majors') IS NOT NULL
--	DROP TABLE Majors
--IF OBJECT_ID('Students') IS NOT NULL
--	DROP TABLE Students
--IF OBJECT_ID('Payments') IS NOT NULL
--	DROP TABLE Payments
--IF OBJECT_ID('Subjects') IS NOT NULL
--	DROP TABLE Subjects
--IF OBJECT_ID('Agenda') IS NOT NULL
--	DROP TABLE Agenda

--CREATE TABLE Majors(
--	MajorID INT IDENTITY PRIMARY KEY,
--	Name NVARCHAR(50) NOT NULL
--)

--CREATE TABLE Students(
--	StudentID INT IDENTITY PRIMARY KEY,
--	StudentNumber INT NOT NULL,
--	StudentName NVARCHAR(50) NOT NULL,
--	MajorID INT,
--	CONSTRAINT FK_Students_Majors FOREIGN KEY (MajorID) REFERENCES Majors(MajorID)
--)

--CREATE TABLE Payments(
--	PaymentID INT IDENTITY PRIMARY KEY,
--	PaymentDate DATE NOT NULL,
--	PaymentAmount MONEY NOT NULL,
--	StudentID INT NOT NULL,
--	CONSTRAINT FK_Payments FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
--)

--CREATE TABLE Subjects(
--	SubjectID INT IDENTITY PRIMARY KEY,
--	SubjectName NVARCHAR(50) NOT NULL
--)

--CREATE TABLE Agenda(
--	StudentID INT,
--	SubjectID INT,
--	CONSTRAINT PK_Agenda PRIMARY KEY(StudentID, SubjectID),
--	CONSTRAINT FK_Agenda_StudentID FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
--	CONSTRAINT FK_Agenda_Subjects FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
--)


USE Geography

SELECT m.MountainRange, p.PeakName, p.Elevation
	FROM Mountains AS m
	JOIN Peaks AS p ON p.MountainId = m.Id
	WHERE m.MountainRange = 'Rila'
	ORDER BY p.Elevation DESC