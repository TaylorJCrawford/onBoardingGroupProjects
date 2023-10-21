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