-- As a member of the Management team I want to be able to assign delivery employees to a project. 
-- A delivery employee can work on multiple projects at the same time and can also work on the 
-- same project more than once.

	-- Assumption Here: DeliveryEmployee Can Only Work On The Same Project At A Single Time,
		-- i.e. Can not be assigned twice to the same project on the same startDate.

INSERT INTO deliveryEmployeesProject (employeeID, projectID, startDate)
	VALUES (2, 1, CURDATE());