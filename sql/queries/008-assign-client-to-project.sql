-- As a member of the Sales team I want to be able to assign a client to a project. 
-- A client can have multiple projects but a project can only have 1 client

	-- Assumption: A project must alway belong to a client.

UPDATE projects
	SET clientID=2
	WHERE projectID = 3;