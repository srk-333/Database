/*-------- UC-1-CreateDB ---------*/
Create Database AddressBookServiceDB;
use AddressBookServiceDB;

/*----------- UC-2-CreateTable ------*/
create table AddressBookTable(
 FirstName varchar(200),
 LastName varchar(200),
 Address varchar(200),
 city varchar(100),
 State varchar(50),
 Zip bigint,
 PhoneNumber bigint,
 Email varchar(100)
);

/*--------- UC-3-InsertIntoTable------*/
insert into AddressBookTable
values('Ritesh','Kumar','bela','gaya','Bihar',855807,8059491316,'Ritesh@gmail.com');
insert into AddressBookTable
values('Rohit','Kumar','Makhdumpur','Jehanabad','Bihar',804422,8051491319,'Rohit@gmail.com'),('Ritesh','Kumar','Danapur','patna','Bihar',233105,8051671319,'Ritesh@gmail.com');
select * from AddressBookTable;

/*------ UC-4-EditExistingContactUsingName--------*/
update AddressBookTable set LastName='Sharma' where FirstName= 'Saurav';

/*----- UC-5-DeleteAPersonUsingName ------*/
delete from AddressBookTable where FirstName='Rohit';

/*------- UC-6-RetriveaPersonBelongingtoSpecificCityorState-- */
select * from AddressBookTable where City='gaya';
select * from AddressBookTable where State='Bihar';
select * from AddressBookTable where City='gaya' or State='Bihar';

/*------- UC-7-GetSizeOfDbbyCityandState -----------*/
select count(City) as numOfRecords from AddressBookTable;
select count(State) as numOfRecords from AddressBookTable;

/*----------UC-8-RetrieveEntriesSortedAlphabetically -------*/
select FirstName from AddressBookTable ORDER BY City ASC;
select City from AddressBookTable ORDER BY FirstName ASC;

/*----- UC-9-AlterTableToAddNameAndType ----------*/
ALTER TABLE AddressBookTable Add Name varchar(200) , Type varchar(50);
update AddressBookTable set Name='Contact' where State='Bihar';
update AddressBookTable set Type='Friends' where City='gaya';
update AddressBookTable set Type='Family' where City='Kishanganj';
update AddressBookTable set Type='Profession' where City='Patna';

select Name from AddressBookTable where Type='Profession';

/*----- UC-10-GetNoofContactsbyType -----*/
select count(Type) as noOfRecords from AddressBookTable where Type='Profession';

/*----- UC-11-AddPersonInToFamilyandFriends --------*/
INSERT INTO AddressBookTable VALUES
('Vikash','Singh','BTM','Bangalore','Karnataka',776655,990452166,'Vikash@gmail.com','Book1','Family'),
('Sidhu','Sharma','NviMumbai','Mumbai','Maharashtra',800098,'7452166','Sidhu@gmail.com','Book2','Friends');

/* ----- UC-12-CreateERDiagram ------*/
select* from AddressBookTable;
Drop table AddressBookTable;
--CREATING TABLE BOOKNAMETYPE
CREATE TABLE BookNameType(
    BookId VARCHAR(50) NOT NULL PRIMARY KEY,
    BkName VARCHAR(200) NOT NULL,
    BkType VARCHAR(50) NOT NULL
);
--CREATING TABLE CONTACT
CREATE TABLE Contact(
    BookId VARCHAR(50) FOREIGN KEY REFERENCES BookNameType(BookId),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Zip BIGINT NOT NULL,
    Phone_no BIGINT,
    Email VARCHAR(100) NOT NULL   
);
--INSERTING DATA IN CONTACT
INSERT INTO Contact
  VALUES('BK1','Saurav','sharma','machhmara','kishanganj','Bihar',989001,9078563412,'v.putin@gmail.com'),
        ('BK2','Ritesh','yadav','danapur','patna','Bihar',567897,565765767,'sherlocked@gmail.com'),
        ('BK3','Rohit','kumar','makhdumpurt','gaya','Bihar',989001,6775675757,'v.putin@gmail.com'),
        ('BK2','Vikash','singh','purvanchal','buxar','Bihar',25679,7453454534,'j.pera@gmail.com'),
        ('BK2','Nandani','sharma','gaya','gaya','Bihar',450981,232355525,'ke.lut@gmail.com'),
        ('BK3','rosa','bosh','patna','patna','Bihar',25679,64564545,'rosa@gmail.com'),
        ('BK1','Piyali','das','durgapur','Kolkata','WestBengal',400098,6575756756,'shakira@gmail.com');
---INSERTING DATA IN BOOKNAMETYPE
INSERT INTO BookNameType
    VALUES('BK1','Book1','Family'),('BK2','Book2','Friends'),('BK3','Book3','Profession');

/* ----- UC-13-RetreiveAllDataAfterErImplementation ----*/
SELECT FirstName, LastName FROM Contact c INNER JOIN BookNameType b
ON c.BookId=b.BookId 
WHERE c.city='patna' OR c.state='Bihar';

SELECT COUNT(c.FirstName) AS TOTAL_COUNT, c.City AS PLACE FROM Contact c INNER JOIN BookNameType b
ON c.BookId=b.BookId 
GROUP BY c.City;

SELECT FirstName, LastName FROM Contact c INNER JOIN BookNameType b
ON c.BookId=b.BookId 
WHERE c.City='patna'
ORDER BY FirstName DESC;

SELECT b.BkType AS Book_Type, COUNT(b.BkType) AS Total_COUNT FROM Contact c INNER JOIN BookNameType b
ON c.BookId=b.BookId 
GROUP BY b.BkType;