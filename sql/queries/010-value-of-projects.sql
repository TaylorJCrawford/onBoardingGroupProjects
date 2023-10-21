-- As a member of the Sales team I want to see a client who has the highest value of projects

SELECT P.projectName, P.clientID, MAX(P.projectValue) AS "Project Value" FROM projects P;

-- As a member of the Sales team I want to see a client who has the lowest value of projects
SELECT P.projectName, P.clientID, MIN(P.projectValue) AS "Project Value" FROM projects P;

-- As a member of the Sales team I want to see a list of clients with the average value of their projects
SELECT P.projectName, P.clientID, AVG(P.projectValue) AS "Project Value" FROM projects P GROUP BY(P.clientID);