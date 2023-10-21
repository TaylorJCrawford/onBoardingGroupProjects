CREATE DATABASE project_TaylorC;
USE project_TaylorC;

/* employees table
	Table Purpose: Store common employee information.
	Linking Tables: None
*/
CREATE TABLE employees (
	employeeID INT AUTO_INCREMENT PRIMARY KEY,
    employeeName VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) UNSIGNED NOT NULL,
    bankAccount VARCHAR(10) NOT NULL UNIQUE,
    nationalInsuranceNumber CHAR(9) NOT NULL UNIQUE
);

DROP PROCEDURE IF EXISTS insertFakeEmployeeData;
DELIMITER $$
	CREATE PROCEDURE insertFakeEmployeeData()
		BEGIN
			START TRANSACTION;

				INSERT INTO employees (employeeName, salary,
                    bankAccount, nationalInsuranceNumber) VALUES
					("Taylor Crawford", 30000.00, "1234567891", "QQ123456Q"),
					("Mat Damon", 40050.00, "1234567892", "PT123456Q"),
					("Tom Cruise", 50050.00, "1234567893", "II123451P"),
					("Denzel Washington", 33050.00, "1234567894", "QY123456Q"),
					("Tom Hanks", 40050.00, "1234567895", "QR123456Q"),
					("Brad Pitt", 990050.00, "1234567896", "QU123456Q");

                   GET DIAGNOSTICS @rows = ROW_COUNT;
					IF @rows != 6 THEN
						ROLLBACK;
						SELECT 'Transaction (insertFakeEmployeeData) rolled back due to error: ' + @rows;
					ELSE
						COMMIT;
						SELECT 'Transaction (insertFakeEmployeeData) committed successfully';
				END IF;
		END $$
DELIMITER ;

CALL insertFakeEmployeeData();

/* salesEmployees table
	Table Purpose: Store a connection with employees table. To indicate which employees are sales.
	Linking Tables: None
*/
CREATE TABLE salesEmployees (
	employeeID INT PRIMARY KEY,
    commissionRate DECIMAL(5,2) UNSIGNED NOT NULL,
    FOREIGN KEY(employeeID) REFERENCES employees(employeeID)
);

DROP PROCEDURE IF EXISTS insertFakeSalesEmployeeData;
DELIMITER $$
	CREATE PROCEDURE insertFakeSalesEmployeeData()
		BEGIN
			START TRANSACTION;

				INSERT INTO salesEmployees (employeeID, commissionRate) VALUES
					(4, 1.5), (5, 0.55), (6, 0.66);
                GET DIAGNOSTICS @rows = ROW_COUNT;
					IF @rows != 3 THEN
						ROLLBACK;
						SELECT 'Transaction (insertFakeSalesEmployeeData) rolled back due to error: ' + @rows;
					ELSE
						COMMIT;
						SELECT 'Transaction (insertFakeSalesEmployeeData) committed successfully';
				END IF;
		END $$
DELIMITER ;

CALL insertFakeSalesEmployeeData();

/* deliveryEmployees table
	Table Purpose: Store a connection with employees table. To indicate which employees are delivery.
	Linking Tables: deliveryEmployeesTech, deliveryEmployeesProject
*/
CREATE TABLE deliveryEmployees (
	employeeID INT PRIMARY KEY,
	FOREIGN KEY(employeeID) REFERENCES employees(employeeID)
);

DROP PROCEDURE IF EXISTS insertFakeDeliveryEmployeeData;
DELIMITER $$
	CREATE PROCEDURE insertFakeDeliveryEmployeeData()
		BEGIN
			START TRANSACTION;

				INSERT INTO deliveryEmployees (employeeID) VALUES
					(1), (2), (3);
                GET DIAGNOSTICS @rows = ROW_COUNT;
					IF @rows != 3 THEN
						ROLLBACK;
						SELECT 'Transaction (insertFakeDeliveryEmployeeData) rolled back due to error: ' + @rows;
					ELSE
						COMMIT;
						SELECT 'Transaction (insertFakeDeliveryEmployeeData) committed successfully';
				END IF;
		END $$
DELIMITER ;

CALL insertFakeDeliveryEmployeeData();

/* clients table
	Table Purpose: Store clients information.
	Linking Tables: None
*/
CREATE TABLE clients (
	clientID INT AUTO_INCREMENT PRIMARY KEY,
    clientName VARCHAR(50) NOT NULL,
    clientAddress VARCHAR(100) NOT NULL,
    clientPhoneNumber CHAR(11) UNIQUE NOT NULL,
    clientWinDate DATE NOT NULL,
    salesEmployeeID INT NOT NULL,
    FOREIGN KEY(salesEmployeeID) REFERENCES salesEmployees(employeeID)
);

DROP PROCEDURE IF EXISTS insertFakeClientData;
DELIMITER $$
	CREATE PROCEDURE insertFakeClientData()
		BEGIN
			START TRANSACTION;

				INSERT INTO clients (clientName, clientAddress, clientPhoneNumber,
					clientWinDate, salesEmployeeID) VALUES
					("Shell", "Shell Road UK", "03214321452", "2000-10-15", 4),
                    ("BP", "BP Road UK", "08432153214", "2010-11-10", 5),
                    ("Tesco", "35 Lisburn Road", "01398547219", "2019-04-03", 6),
                    ("Legal And General", "34 Belfast Road", "09873209831", "2017-10-03", 4);

                GET DIAGNOSTICS @rows = ROW_COUNT;
					IF @rows != 4 THEN
						ROLLBACK;
						SELECT 'Transaction (insertFakeClientData) rolled back due to error: ' + @rows;
					ELSE
						COMMIT;
						SELECT 'Transaction (insertFakeClientData) committed successfully';
				END IF;
		END $$
DELIMITER ;

CALL insertFakeClientData();

/* projects table
	Table Purpose: Store information relating to projects.
	Linking Tables: deliveryEmployeesProject, techProject
*/
CREATE TABLE projects (
	projectID INT AUTO_INCREMENT PRIMARY KEY,
    projectName VARCHAR(50) NOT NULL,
    projectValue DECIMAL(15,2) UNSIGNED NOT NULL,
    projectCreated DATE NOT NULL,
    clientID INT NOT NULL,
    techLeadID INT NULL,
    completedDate Date NULL,
    FOREIGN KEY(clientID) REFERENCES clients(clientID),
    FOREIGN KEY(techLeadID) REFERENCES deliveryEmployees(employeeID)
);

DROP PROCEDURE IF EXISTS insertFakeProjectData;
DELIMITER $$
	CREATE PROCEDURE insertFakeProjectData()
		BEGIN
			START TRANSACTION;

				INSERT INTO projects (projectName, projectValue, projectCreated, clientID, techLeadID, completedDate)
					VALUES
                    ("Shell POS System", 1000000.00, CURDATE(), 1, 1, NULL),
                    ("BP ME Loyalty System", 50000.00, CURDATE(), 2, 2, NULL),
                    ("Shell Self Drive", 50000.00, CURDATE(), 1, 3, NULL);
                GET DIAGNOSTICS @rows = ROW_COUNT;
					IF @rows != 3 THEN
						ROLLBACK;
						SELECT 'Transaction (insertFakeProjectData) rolled back due to error: ' + @rows;
					ELSE
						COMMIT;
						SELECT 'Transaction (insertFakeProjectData) committed successfully';
				END IF;
		END $$
DELIMITER ;

CALL insertFakeProjectData();

/* deliveryEmployeesProject table
	Table Purpose: Used to link delivery employees and who are working or have worked on a project.
	Linking Tables: NA
*/
CREATE TABLE deliveryEmployeesProject (
	employeeID INT,
    projectID INT,
    startDate DATE NOT NULL,
    endDate DATE NULL,
    FOREIGN KEY(employeeID) REFERENCES deliveryEmployees(employeeID),
    FOREIGN KEY(projectID) REFERENCES projects(projectID),
    PRIMARY  KEY(employeeID, projectID, startDate)
);

DROP PROCEDURE IF EXISTS insertFakeDeliveryEmployeeProjectData;
DELIMITER $$
	CREATE PROCEDURE insertFakeDeliveryEmployeeProjectData()
		BEGIN
			START TRANSACTION;

				INSERT INTO deliveryEmployeesProject (employeeID, projectID, startDate, endDate)
					VALUES
                    (1, 1, "2020-10-13", NULL),
                    (1, 2, "2022-12-10", "2023-01-15");
                GET DIAGNOSTICS @rows = ROW_COUNT;
					IF @rows != 2 THEN
						ROLLBACK;
						SELECT 'Transaction (insertFakeDeliveryEmployeeProjectData) rolled back due to error: ' + @rows;
					ELSE
						COMMIT;
						SELECT 'Transaction (insertFakeDeliveryEmployeeProjectData) committed successfully';
				END IF;
		END $$
DELIMITER ;
CALL insertFakeDeliveryEmployeeProjectData();

/* technology table
	Table Purpose: Stores information relating to technologies.
	Linking Tables: deliveryEmployeeTech, techProject
*/
CREATE TABLE technology (
	techID INT AUTO_INCREMENT PRIMARY KEY,
    techName VARCHAR(50) NOT NULL
);

DROP PROCEDURE IF EXISTS insertFakeTechData;
DELIMITER $$
	CREATE PROCEDURE insertFakeTechData()
		BEGIN
			START TRANSACTION;

				INSERT INTO technology (techName)
					VALUES
                    ("MySQL Database"),
                    ("Artificial intelligence"),
                    ("Node JS");
                GET DIAGNOSTICS @rows = ROW_COUNT;
					IF @rows != 3 THEN
						ROLLBACK;
						SELECT 'Transaction (insertFakeTechData) rolled back due to error: ' + @rows;
					ELSE
						COMMIT;
						SELECT 'Transaction (insertFakeTechData) committed successfully';
				END IF;
		END $$
DELIMITER ;

CALL insertFakeTechData();

/* technologyProject table
	Table Purpose: Information relating to what projects have which technologies.
	Linking Tables: NA
*/
CREATE TABLE technologyProject (
	projectID INT,
    techID INT,
	FOREIGN KEY(projectID) REFERENCES projects(projectID),
    FOREIGN KEY(techID) REFERENCES technology(techID),
    PRIMARY  KEY(projectID, techID)
);

DROP PROCEDURE IF EXISTS insertFakeTechProjectData;
DELIMITER $$
	CREATE PROCEDURE insertFakeTechProjectData()
		BEGIN
			START TRANSACTION;

				INSERT INTO technologyProject (projectID, techID)
					VALUES
                    (1, 1), (1, 3), (2, 2);
                GET DIAGNOSTICS @rows = ROW_COUNT;
					IF @rows != 3 THEN
						ROLLBACK;
						SELECT 'Transaction (insertFakeTechProjectData) rolled back due to error: ' + @rows;
					ELSE
						COMMIT;
						SELECT 'Transaction (insertFakeTechProjectData) committed successfully';
				END IF;
		END $$
DELIMITER ;

CALL insertFakeTechProjectData();

/* deliveryEmployeeTechnology table
	Table Purpose: Information realting to which employees have work with which technologies.
	Linking Tables: NA
*/
CREATE TABLE deliveryEmployeeTechnology (
	employeeID INT,
    techID INT,
	FOREIGN KEY(employeeID) REFERENCES deliveryEmployees(employeeID),
    FOREIGN KEY(techID) REFERENCES technology(techID),
    PRIMARY  KEY(employeeID, techID)
);


DROP PROCEDURE IF EXISTS insertFakeDeliveryEmployeeTechnolgoyData;
DELIMITER $$
	CREATE PROCEDURE insertFakeDeliveryEmployeeTechnolgoyData()
		BEGIN
			START TRANSACTION;

				INSERT INTO deliveryEmployeeTechnology (employeeID, techID)
					VALUES
                    (1, 1), (1, 3), (2, 2);
                GET DIAGNOSTICS @rows = ROW_COUNT;
					IF @rows != 3 THEN
						ROLLBACK;
						SELECT 'Transaction (insertFakeDeliveryEmployeeTechnolgoyData) rolled back due to error: ' + @rows;
					ELSE
						COMMIT;
						SELECT 'Transaction (insertFakeDeliveryEmployeeTechnolgoyData) committed successfully';
				END IF;
		END $$
DELIMITER ;

CALL insertFakeDeliveryEmployeeTechnolgoyData();
