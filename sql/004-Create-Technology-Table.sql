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

-- Table Stores Information Relating To What Projects Have Which Technologies.
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

-- Table Stores Information Relating To Which Employees Have Worked With Technology.
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