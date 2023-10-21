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