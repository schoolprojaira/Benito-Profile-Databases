CREATE DATABASE IF NOT EXISTS Benito_ProfileDatabase;
USE Benito_ProfileDatabase;

CREATE TABLE IF NOT EXISTS Profile (
    Profile_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(150),
    Age INT,
    Department VARCHAR(50),
    Position VARCHAR(50)
);

INSERT INTO Profile (Profile_ID, Name, Address, Age, Department, Position) VALUES
(1, 'Katniss Everdeen', 'District 12 Seam', 16, 'Human Resource', 'Junior HR'),
(2, 'Peeta Mellark', 'District 12 Town', 16, 'Finance & Accounting', 'Junior Accountant'),
(3, 'Haymitch Abernathy', 'Victors Village', 40, 'Strategic Planning', 'Manager'),
(4, 'Effie Trinket', 'The Capitol', 35, 'Public Relations', 'Director'),
(5, 'President Snow', 'Capitol Mansion', 75, 'Strategic Planning', 'Director');


CREATE DATABASE IF NOT EXISTS Benito_ProfileDatabase_Backup;
USE Benito_ProfileDatabase_Backup;

CREATE TABLE IF NOT EXISTS Profile (
    Profile_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(150),
    Age INT,
    Department VARCHAR(50),
    Position VARCHAR(50)
);

INSERT INTO Profile SELECT * FROM Benito_ProfileDatabase.Profile;

ALTER TABLE Profile 
    MODIFY Name VARBINARY(255),
    MODIFY Address VARBINARY(255),
    MODIFY Age VARBINARY(255),
    MODIFY Department VARBINARY(255),
    MODIFY Position VARBINARY(255);

UPDATE Profile 
SET 
    Name = AES_ENCRYPT(Name, 'PanemSecretKey123'),
    Address = AES_ENCRYPT(Address, 'PanemSecretKey123'),
    Age = AES_ENCRYPT(CAST(Age AS CHAR), 'PanemSecretKey123'),
    Department = AES_ENCRYPT(Department, 'PanemSecretKey123'),
    Position = AES_ENCRYPT(Position, 'PanemSecretKey123');


SELECT * FROM Profile;

SELECT 
    Profile_ID,
    CAST(AES_DECRYPT(Name, 'PanemSecretKey123') AS CHAR) AS Name,
    CAST(AES_DECRYPT(Address, 'PanemSecretKey123') AS CHAR) AS Address,
    CAST(AES_DECRYPT(Age, 'PanemSecretKey123') AS CHAR) AS Age,
    CAST(AES_DECRYPT(Department, 'PanemSecretKey123') AS CHAR) AS Department,
    CAST(AES_DECRYPT(Position, 'PanemSecretKey123') AS CHAR) AS Position
FROM Profile
WHERE Profile_ID IN (2, 3);
