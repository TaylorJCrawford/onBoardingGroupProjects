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

-- Link Table Between Delivery Employees AND Projects, Used To Link Delivery Employees How Have Work Or Are Working On A Project.

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