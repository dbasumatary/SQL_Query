CREATE DATABASE AddressBookDB;
USE AddressBookDB;

CREATE TABLE Contact(contactID int primary key identity(1,1), FirstName varchar(50) not null, LastName varchar(50) not null,
                     Email varchar(100));

CREATE TABLE AddressDetails(contactID int , City varchar(50), State varchar(50), Birthday date not null, ZipCode int, Phone int,
                    foreign key (contactID) references Contact(contactID));

INSERT INTO Contact(FirstName, LastName,Email) VALUES ('Kundan', 'Kumar', 'kundan@ggg.com');
INSERT INTO Contact(FirstName, LastName,Email) VALUES ('Praveen', 'Kumar', 'praveen@ggg.com');
INSERT INTO Contact(FirstName, LastName,Email) VALUES ('Rohith', 'Kumar', 'rohith@ggg.com');
INSERT INTO Contact(FirstName, LastName,Email) VALUES ('Dhondip', 'Basumatary', 'dhondip@ggg.com');

INSERT INTO AddressDetails VALUES ('1','Siwar','Bihar','1998-04-26',123456,3254367),
								('2','Bangalore','Karnataka','1996-03-26',543257,8673081),
								('3','Hyderabad','Telangana','2001-08-08',321439,9047831),
								('1','Mumbai','Maharashtra','1998-07-24',432178,5432987),
								('5','Kokrajhar','Assam','1997-06-27',321905,7863208),
								('2','Mysuru','Karnataka','2001-07-04',132786,5438081),
								('3','Vizag','Telangana','1995-09-10',432960,8974061);

SELECT * FROM Contact;
SELECT * FROM AddressDetails;

UPDATE Contact SET Email = 'rohith@jjj.com' WHERE FirstName = 'Rohith';
UPDATE AddressDetails SET State = 'Andhra' WHERE contactID = 3;

DELETE FROM AddressDetails WHERE contactID = 4;
DELETE FROM Contact WHERE FirstName = 'Dhondip';

SELECT COUNT(*) AS PeopleCount FROM Contact;
SELECT COUNT(*) AS PeopleCount FROM Contact WHERE LastName = 'Kumar';

SELECT MAX(LastName) FROM Contact;
SELECT MIN(City) FROM AddressDetails;
SELECT FirstName,LastName,Email,City,State from Contact inner join  AddressDetails on Contact.contactID = AddressDetails.contactID; 

SELECT * FROM AddressDetails ORDER BY City;
SELECT * FROM AddressDetails ORDER BY State Desc;
SELECT * FROM AddressDetails ORDER BY Birthday Asc;

