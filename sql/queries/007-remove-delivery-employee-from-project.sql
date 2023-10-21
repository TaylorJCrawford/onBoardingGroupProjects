-- As a member of the Management team I want to be able to remove a delivery employee from a project.
-- A record should be retained to show that person worked on that project at some point

UPDATE deliveryEmployeesProject 
	SET endDate=CURDATE()
	WHERE employeeID = 1 AND projectID = 1;