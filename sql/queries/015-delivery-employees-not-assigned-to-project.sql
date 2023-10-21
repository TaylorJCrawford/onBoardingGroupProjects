-- As a member of the Management team I want to be able to see a list of delivery employees
-- who are not assigned to a project who have previously worked with a technology that
-- is currently being used on a project and the name of those projects.

DROP PROCEDURE IF EXISTS deliveryEmployeesNotAssignedToAProject;
DELIMITER $$
		CREATE PROCEDURE deliveryEmployeesNotAssignedToAProject(technologySearch Varchar(100))
			BEGIN
				SELECT E.employeeID, E.employeeName, GROUP_CONCAT(projectName SEPARATOR ', ') AS "Related Projects" FROM employees E
					INNER JOIN deliveryEmployees ON E.employeeID = deliveryEmployees.employeeID
					INNER JOIN deliveryEmployeeTechnology DET ON E.employeeID = DET.employeeID
					INNER JOIN technology T ON DET.techID = T.techID
					LEFT JOIN deliveryEmployeesProject DEP ON deliveryEmployees.employeeID = DEP.employeeID
					INNER JOIN technologyProject TP ON T.techID = TP.techID
					INNER JOIN projects P ON TP.projectID = P.projectID
					WHERE DEP.projectID IS NULL AND T.techName = technologySearch
					GROUP BY E.employeeID;
			END $$
DELIMITER ;

CALL deliveryEmployeesNotAssignedToAProject("Artificial intelligence");