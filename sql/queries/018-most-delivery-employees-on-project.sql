-- As a member of the Management team I want to be able to see the project with the
	-- most delivery employees currently working on it

SELECT P.projectName, COUNT(DEP.employeeID) AS `Count` FROM projects P
	INNER JOIN deliveryEmployeesProject DEP ON P.projectID = DEP.projectID
    GROUP BY (P.projectID)
    ORDER BY `Count` DESC LIMIT 1;