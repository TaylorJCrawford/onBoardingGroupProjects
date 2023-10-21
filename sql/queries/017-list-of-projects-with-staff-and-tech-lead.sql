-- As a member of the Management team I want to be able to see a list of projects, 
	-- the name of the Tech Lead and a list of all delivery employees assigned to the project

	-- ASSUMPTION MADE That if no staff are assigned to a project its not important.

INSERT INTO deliveryEmployeesProject (employeeID, projectID, startDate) 
	VALUES (2, 1, CURDATE());
    
SELECT P.projectName, GROUP_CONCAT(E.employeeName SEPARATOR ', ') AS "Assigned Staff", 
	(SELECT employeeName FROM employees WHERE employeeID = P.techLeadID) AS TechLead
	FROM projects P
	RIGHT JOIN deliveryEmployeesProject DEP ON P.projectID = DEP.projectID
    INNER JOIN employees E ON DEP.employeeID = E.employeeID
    WHERE DEP.endDate IS NULL AND P.completedDate IS NULL
    GROUP BY P.projectID;