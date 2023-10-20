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