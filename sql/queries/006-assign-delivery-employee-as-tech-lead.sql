-- As a member of the Management team I want to be able to assign a
-- delivery employee as a Tech Lead to a project. Each project can only have 1 Tech Lead

UPDATE projects
	SET P.techLeadID=2
	WHERE P.projectID = 3;