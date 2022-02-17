----- UC-1 --------
create database payroll;
use payroll;
--------- UC-2 -------
create table employee_pay(
      ID int IDENTITY(1,1) PRIMARY KEY,
	  Name varchar(200),
	  Salary float,
	  StartDate Date
);
--------- UC-3 -----------
insert into employee_pay values('Saurav',50000,'07/08/2021');
insert into employee_pay (Name, Salary)
values('Vikki', 40000),('ritesh',35000);
--------- UC-4 -----------
select * from employee_pay;
----------- UC-5 ---------
select * from employee_pay where Name='Vikki' or Name='Saurav';
select Salary from employee_pay where Name='Saurav';
select * from employee_pay where StartDate between cast('2010-01-01' as date) and getdate();

------- UC-6 --------
Alter table employee_pay add Gender char(1);
select * from employee_pay;
insert into employee_pay
values('shruti',25000,'07-08-2020','F'),('varsha',30000,'05-11-2019','F');

update employee_pay set Gender='M' where ID=12 or ID=13;
update employee_pay set Gender='M' where ID=1;
select * from employee_pay;

------- UC-7 --------
select sum(Salary) as salary,Gender from employee_pay group by Gender;
select sum(Salary) as MaleSalary from employee_pay where Gender='M';
select sum(Salary) as FemaleSalary from employee_pay where Gender='F';
select sum(Salary) as TotalSalary from employee_pay;

select avg(Salary) as AvgSalary from employee_pay;
select Min(Salary) as MinSalary from employee_pay where Gender='F';
select Min(Salary) as MinSalary from employee_pay where Gender='M';

select Max(Salary) as MaxSalary from employee_pay where Gender='F';
select Max(Salary) as MaxSalary from employee_pay where Gender='M';

select COUNT(Name) from employee_pay;
select * from employee_pay;
insert into employee_pay
values('Sunil',55000,'01-11-2004','M');

---------- UC-8 ---------
Alter table employee_pay add phone bigint;
Alter table employee_pay add Department varchar(200) not null default 'HR';
Alter table employee_pay add Address varchar(200) default 'bihar';
select * from employee_pay;
update employee_pay set phone=9078563412 ;
update employee_pay set Department='Testing' where ID in(12,15);
update employee_pay set address='Bihar' where ID in(12,15,1);
update employee_pay set address='Mumbai' where ID in(13,14,16);

---------- Rename -------
Exec sp_rename 'employee_pay.address','Address','COLUMN';
Exec sp_rename 'employee_pay.Salary','BaseSaary','COLUMN';
select * from employee_pay;
Exec sp_rename 'employee_pay.BaseSaary','BaseSalary','COLUMN';

---- UC-9-ExtendEmployeePayTablewithNewColumns ----
Alter table employee_pay add BasicPay float;
Alter table employee_pay add Deductions float;
Alter table employee_pay add TaxablePay float;
Alter table employee_pay add IncomeTax float;
Alter table employee_pay add NetPay float;
select * from employee_pay;

------- UC-10-InsertTerissa --------
INSERT INTO employee_pay 
	VALUES('Terissa',35000,'2019-10-31','F',123456789,'Marketing','Mumbai',1000,14000,1400,12600,1000),('Terissa',35000,'2019-10-31','F',123456789,'Sales','Mumbai',1,14,14,12,90);
------usecase11
-- drop & recreate the tables according to ER Diagram
DROP TABLE employee_pay;
--Creating table Company
CREATE TABLE Company(
    company_id INT NOT NULL PRIMARY KEY,
    company_name VARCHAR(30) NOT NULL,
);
--Inserting data into table Company
INSERT INTO Company(company_id,company_name)
    VALUES(101,'BridgeLabz'),(102,'Magic'),(103,'Google');
--Creating table Employee
CREATE TABLE Employee(
    employee_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    employee_name VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    phone_no VARCHAR(15),
    address VARCHAR(100)
);
--Inserting data into table Employee
INSERT INTO Employee(employee_name,gender,phone_no,address)
    VALUES('sachin','M','9899125354','Mumbai'),('shalini','F','7896534218','Delhi'),
            ('bill','M','6578923546','Moscow'),('roshni','F','8796345567','bangalore');
--Creating table Department
CREATE TABLE Department(
    department_id INT NOT NULL PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id)
);
--Inserting into table Department
INSERT INTO Department(department_id,department_name,employee_id)
    VALUES(333,'.Net Rpa',1),(444,'Java',2),(222,'Sales',3),(555,'Marketing',4);
--Creating table Payroll
CREATE TABLE Payroll(
    payroll_id VARCHAR(20) NOT NULL PRIMARY KEY,
    basic_pay DECIMAL(10,2),
    deduction DECIMAL(10,2),
    taxable_pay DECIMAL(10,2),
    tax DECIMAL(10,2),
    net_pay DECIMAL(10,2),
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id)
);
--Inserting into table Payroll
INSERT INTO Payroll(payroll_id,basic_pay,deduction,taxable_pay,tax,net_pay,employee_id)
    VALUES('#1245',10000,500,9500,950,8550,1),('#8765',15000,750,14250,1425,12825,2),
            ('#7689',25000,3000,22000,2200,19800,3),('#9008',29000,3500,25500,2550,22950,4);
--UC-12
--Redoing usecase7 to perform database functions and use group by function
--Using joins
SELECT SUM(basic_pay) AS SALARY_F, AVG(taxable_pay) AS AVERAGE_F, 
        MIN(tax) AS MINIMUM_F, MAX(net_pay) AS MAXIMUM_F, COUNT(payroll_id) AS COUNT_PAYROLL
    FROM Payroll p INNER jOIN Employee e
    ON p.employee_id=e.employee_id
    WHERE e.gender = 'F' GROUP BY e.gender;

SELECT SUM(basic_pay) AS SALARY_M, AVG(taxable_pay) AS AVERAGE_M, 
        MIN(tax) AS MINIMUM_M, MAX(net_pay) AS MAXIMUM_M, COUNT(payroll_id) AS COUNT_PAYROLL
    FROM Payroll p INNER jOIN Employee e
    ON p.employee_id=e.employee_id
    WHERE e.gender = 'M' GROUP BY e.gender;
