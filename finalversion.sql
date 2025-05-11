DROP TABLE IF EXISTS Unnormalized_Data;
DROP TABLE IF EXISTS NF1_Data;
DROP TABLE IF EXISTS NF2_3_Data_Book;
DROP TABLE IF EXISTS NF2_3_Data_Course;
DROP TABLE IF EXISTS NF2_3_Data_Relation;
DROP TABLE IF EXISTS NF3_Data_Publishing;
DROP TABLE IF EXISTS Book_Records;

--Table for unnormalized data.
CREATE TABLE Unnormalized_Data (
    CRN INT,
    ISBN BIGINT,
    Title VARCHAR(255),
    Authors VARCHAR(255),
    Edition INT,
    Publisher VARCHAR(255),
    Publisher_Address VARCHAR(255),
    Pages INT,
    Years INT,
    Course_Name VARCHAR(255),
	PRIMARY KEY(CRN,ISBN)
);
--SELECT * FROM Unnormalized_Data;
COPY Unnormalized_Data (CRN, ISBN, Title, Authors, Edition, Publisher, Publisher_Address, Pages, Years, Course_Name)
FROM 'C:/data/Unnormalized1 (2) (1).csv' DELIMITER ',' CSV HEADER;

--Table for separating authors so that it is in 1NF.
--SELECT * FROM NF1_Data;
CREATE TABLE NF1_Data AS
SELECT
    CRN,
    ISBN,
    Title,
    trim(unnest(string_to_array(Authors, ','))) AS Author,  
    Edition,
    Publisher,
	Publisher_address,
    Pages,
    Years,
    Course_Name
FROM Unnormalized_Data;


--Table for separating Book attributes to prevent partial dependency.
--SELECT * FROM NF2_3_Data_Book;
CREATE TABLE NF2_3_Data_Book AS
SELECT DISTINCT
	ISBN,
	Title,
	Author,
	Edition,
	Publisher,
	Publisher_address,
	Pages,
	Years
FROM NF1_Data;


--Table for separating Course attributes to prevent partial dependency
--SELECT * FROM NF2_3_Data_Course;
CREATE TABLE NF2_3_Data_Course AS
SELECT DISTINCT
	CRN,
	Course_Name
FROM NF1_Data;


--Table for displaying relationship between CRN and ISBN.
--SELECT * FROM NF2_3_Data_Relation;
CREATE TABLE NF2_3_Data_Relation AS
SELECT DISTINCT
	CRN,
	ISBN
FROM NF1_Data;


--Table for the connection of Publisher Address according to the Publisher in order to prevent transitive dependency.
CREATE TABLE NF3_Data_Publishing AS
SELECT DISTINCT
    Publisher,
    Publisher_address
FROM NF2_3_Data_Book;

--Assign Publisher to the table as a primary key.
ALTER TABLE NF3_Data_Publishing
ADD PRIMARY KEY (Publisher);

--Altering table NF2_3_Data_Book to drop Publisher address since it is transitively dependent.
ALTER TABLE NF2_3_Data_Book
DROP COLUMN Publisher_address;

--Altering table NF2_3_Data_Book to add Publisher as a foreign key that references NF3_Data_Publishing.
ALTER TABLE NF2_3_Data_Book
ADD CONSTRAINT fk_publisher
FOREIGN KEY (Publisher) REFERENCES NF3_Data_Publishing(Publisher);

--SELECT * FROM NF2_3_Data_Book;








