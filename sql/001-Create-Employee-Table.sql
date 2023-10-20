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