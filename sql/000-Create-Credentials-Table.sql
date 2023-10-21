CREATE TABLE credentials (
	credID INT AUTO_INCREMENT PRIMARY KEY,
    userName VARCHAR(50) UNIQUE NOT NULL,
    saltValue CHAR(32) NOT NULL,
    hashPassword VARCHAR(32) NOT NULL,
    employeeID INT NOT NULL,
    FOREIGN KEY(employeeID) REFERENCES employeeID(employeeID)
);