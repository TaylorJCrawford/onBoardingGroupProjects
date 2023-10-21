-- As a member of the Management team I want to be able to set a project as completed.
	-- Completed projects shouldn't be included in any of the lists

UPDATE projects SET
	completedDate = CURDATE()
		WHERE projectID=3;