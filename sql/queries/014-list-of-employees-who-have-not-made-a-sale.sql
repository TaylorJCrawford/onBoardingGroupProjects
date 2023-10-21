-- As a member of the HR team I want to see a list of sales employees who haven't won any clients this year

INSERT INTO clients (clientName, clientAddress, clientPhoneNumber, clientWinDate, salesEmployeeID)
	VALUES ("Asda", "23 South Lakes", "12432532109", CURDATE(), 4);

SELECT E.employeeName, MAX(C.clientWinDate) AS `Last Sale` FROM salesEmployees SE
	INNER JOIN employees E ON SE.employeeID = E.employeeID
    INNER JOIN clients C ON SE.employeeID = C.salesEmployeeID
    GROUP BY SE.employeeID
    HAVING NOT `Last Sale` > DATE_SUB(NOW(),INTERVAL 1 YEAR)