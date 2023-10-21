-- As a member of the Sales team I want to see a list of clients, 
-- the name of the sales employee who works with that client and the list of projects that the client has

SELECT C.clientName AS "Client Name", E.employeeName AS "Sales Employee", GROUP_CONCAT(P.projectName SEPARATOR ", ") AS "Projects"
	FROM clients C
    INNER JOIN employees E ON C.salesEmployeeID = E.employeeID
    INNER JOIN projects P ON C.clientID = P.clientID
    GROUP BY (P.clientID);