-- As a member of the HR team I want to see a list of sales employees and how much each has made in commission this year
	-- Commission = salesEmployees.commissionRate * projectValue

SELECT * FROM projects;
INSERT INTO projects (projectName, projectValue, projectCreated, clientID, techLeadID)
	VALUES ("Legal Main Frame", 20000000, CURDATE(), 4, 2);

CREATE VIEW salesEmployeeCommissionView AS
SELECT SE.employeeID, E.employeeName, SUM((SE.commissionRate * P.projectValue)) AS "Commission"
	FROM salesEmployees SE
    INNER JOIN employees E ON SE.employeeID = E.employeeID
    INNER JOIN clients C ON SE.employeeID = C.salesEmployeeID
    INNER JOIN projects P ON C.clientID = P.clientID
    WHERE P.projectCreated > DATE_SUB(NOW(),INTERVAL 1 YEAR)
    GROUP BY (SE.employeeID);