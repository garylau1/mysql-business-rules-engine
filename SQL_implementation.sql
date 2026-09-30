DROP TABLE IF EXISTS Borrowedby, Holding, Authoredby, Author, Book, Publisher, Member, Branch;

/*Table structure for table `branch` */
CREATE TABLE Branch (
  BranchID INT NOT NULL, 
  BranchSuburb varchar(255) NOT NULL,
  BranchState char(3) NOT NULL,
  PRIMARY KEY (BranchID)
);

CREATE TABLE Member (
  MemberID INT NOT NULL, 
  MemberStatus char(9) DEFAULT 'REGULAR',
  MemberName varchar(255) NOT NULL,
  MemberAddress varchar(255) NOT NULL,
  MemberSuburb varchar(25) NOT NULL,
  MemberState char(3) NOT NULL,
  MemberExpDate DATE,
  MemberPhone varchar(10),
  PRIMARY KEY (`MemberID`)
);

CREATE TABLE Publisher (
  PublisherID INT NOT NULL, 
  PublisherName varchar(255) NOT NULL,
  PublisherAddress varchar(255) DEFAULT NULL,
  PRIMARY KEY (PublisherID)
);

CREATE TABLE Book (
  BookID INT NOT NULL,
  BookTitle varchar(255) NOT NULL,
  PublisherID INT NOT NULL,
  PublishedYear INT4,
  Price Numeric(5,2) NOT NULL,
  PRIMARY KEY (BookID),
  KEY PublisherID (PublisherID),
  CONSTRAINT publisher_fk_1 FOREIGN KEY (PublisherID) REFERENCES Publisher (PublisherID) ON DELETE RESTRICT
);

CREATE TABLE Author (
  AuthorID INT NOT NULL, 
  AuthorName varchar(255) NOT NULL,
  AuthorAddress varchar(255) NOT NULL,
  PRIMARY KEY (AuthorID)
);

CREATE TABLE Authoredby (
  BookID INT NOT NULL,
  AuthorID INT NOT NULL, 
  PRIMARY KEY (BookID,AuthorID),
  KEY BookID (BookID),
  KEY AuthorID (AuthorID),
  CONSTRAINT book_fk_1 FOREIGN KEY (BookID) REFERENCES Book (BookID) ON DELETE RESTRICT,
  CONSTRAINT author_fk_1 FOREIGN KEY (AuthorID) REFERENCES Author (AuthorID) ON DELETE RESTRICT
);

CREATE TABLE Holding (
  BranchID INT NOT NULL, 
  BookID INT NOT NULL,
  InStock INT DEFAULT 1,
  OnLoan INT DEFAULT 0,
  PRIMARY KEY (BranchID, BookID),
  KEY BookID (BookID),
  KEY BranchID (BranchID),
  CONSTRAINT holding_cc_1 CHECK(InStock>=OnLoan),
  CONSTRAINT book_fk_2 FOREIGN KEY (BookID) REFERENCES Book (BookID) ON DELETE RESTRICT,
  CONSTRAINT branch_fk_1 FOREIGN KEY (BranchID) REFERENCES Branch (BranchID) ON DELETE RESTRICT
);

CREATE TABLE Borrowedby (
  BookIssueID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  BranchID INT NOT NULL,
  BookID INT NOT NULL,
  MemberID INT NOT NULL,
  DateBorrowed DATE,
  DateReturned DATE DEFAULT NULL,
  ReturnDueDate DATE,
  PRIMARY KEY (BookIssueID),
  KEY BookID (BookID),
  KEY BranchID (BranchID),
  KEY MemberID (MemberID),
  CONSTRAINT borrowedby_cc_1 CHECK(DateBorrowed<ReturnDueDate),
  CONSTRAINT holding_fk_1 FOREIGN KEY (BookID,BranchID) REFERENCES Holding (BookID,BranchID) ON DELETE RESTRICT,
  CONSTRAINT member_fk_1 FOREIGN KEY (MemberID) REFERENCES Member (MemberID) ON DELETE RESTRICT
) ;


DELETE FROM Author;
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('1', 'Tolstoy','Russian Empire');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('2', 'Tolkien','England');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('3', 'Asimov','America');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('4', 'Silverberg','America');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('5', 'Paterson','Australia');

DELETE FROM Branch;
INSERT INTO Branch (BranchID,BranchSuburb,BranchState) 
VALUES ('1','Parramatta','NSW');
INSERT INTO Branch (BranchID,BranchSuburb,BranchState) 
VALUES ('2','North Ryde','NSW');
INSERT INTO Branch (BranchID,BranchSuburb,BranchState) 
VALUES ('3','Sydney City','NSW');

DELETE FROM Publisher;
INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress ) 
VALUES ('1','Penguin','New York');
INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress ) 
VALUES ('2','Platypus','Sydney');
INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress ) 
VALUES ('3','Another Choice','Patagonia');

DELETE FROM Member;
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('1','REGULAR','Joe','4 Nowhere St','Here','NSW','2021-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('2','REGULAR','Pablo','10 Somewhere St','There','ACT','2022-09-30','0412345678');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('3','REGULAR','Chen','23/9 Faraway Cl','Far','QLD','2020-11-30','0412346578');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('4','REGULAR','Zhang','Dunno St','North','NSW','2020-12-31','');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('5','REGULAR','Saleem','44 Magnolia St','South','SA','2020-09-30','1234567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('6','SUSPENDED','Homer','Middle of Nowhere','North Ryde','NSW','2020-09-30','1234555811');
INSERT INTO Member(MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('7','REGULAR','zebra','4 Nowhere St','Here','NSW','2024-09-30','0434567811');

INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('8','REGULAR','peter_2','4 Nowhere St','Here','NSW','2021-09-30','0434567811');


INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('9','REGULAR','peter_3','4 Nowhere St','Here','NSW','2019-06-30','0434567811');

INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('10','REGULAR','peter_4','4 Nowhere St','Here','NSW','2024-06-30','0434567811');

INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('11','REGULAR','peter_5','4 Nowhere St','Here','NSW','2023-06-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('12','REGULAR','peter_6','5 Nowhere St','Here','NSW','2024-06-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('13','REGULAR','peter_8','5 Nowhere St','Here','NSW','2026-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('14','REGULAR','peter_9','5 Nowhere St','Here','NSW','2026-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('15','REGULAR','peter_10','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('16','REGULAR','peter_11','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('17','REGULAR','peter_12','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('18','REGULAR','peter_13','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('19','REGULAR','peter_14','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('20','REGULAR','peter_15','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('21','REGULAR','peter_16','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('22','REGULAR','peter_17','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('23','REGULAR','peter_18','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('24','REGULAR','peter_19','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('25','REGULAR','peter_20','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('26','REGULAR','peter_21','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('27','REGULAR','peter_22','5 Nowhere St','Here','NSW','2024-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('28','REGULAR','peter_23','5 Nowhere St','Here','NSW','2024-09-30','0434567811');

DELETE FROM Book;
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('1','Anna Karenina','1','2003',12.75);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('2','War and Peace','2','1869',139.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('3','The Hobbit','2','1937',9.19);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('4','I, Robot','2','1950',29.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('5','The Positronic Man','3','2010',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('6','The Positronic Man','3','2010',125.99);



DELETE FROM Authoredby;
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('1', '1');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('2', '1');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('3', '2');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('4', '3');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('5', '3');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('5', '4');

DELETE FROM Holding;
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('1', '1','2','2');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('1', '2','2','1');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('1', '3','3','1');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('2', '1','1','1');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('2', '4','3','2');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('3', '4','4','0');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('3', '5','2','1');

DELETE FROM Borrowedby;
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '1','2',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('2', '4','4',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('2', '1','4',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('2', '4','1',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('3', '5','3',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '1','1','2020-08-30',NULL,'2020-09-30');
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '2','2','2020-08-30',NULL,'2020-09-30');
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('3', '4','2','2020-08-30',NULL,'2020-09-30');



# question1: insert a new column to record the fine in table member

ALTER TABLE Member
ADD COLUMN fine_logging DOUBLE(10,2);

#question 1b: test it if the fine_logging column exists or not
select * from Member;

#we have other part in question 1b below as well.



#create a table for logging times of suspended for each members

CREATE TABLE Count_status (
  MemberID INT(11) , 
  MemberName varchar(255),
  MemberStatus varchar(9),
  Status_changing_date datetime,
  PRIMARY KEY (MemberID, Status_changing_date)
  );

  
#question2 (a)(b) We create a trigger to turned a suspended member into regular member
  
DELIMITER //
drop trigger if exists overdue ;
CREATE trigger overdue
BEFORE UPDATE ON member 
for each ROW
begin
DECLARE msg VARCHAR (255);
if NEW.fine_logging<0 then 
set msg ="wrong output in the fine";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;
#cannot get negative input in the fine
ELSE 
IF(NEW.fine_logging=0 or NEW.fine_logging is NULL)and (OLD.MemberStatus= "SUSPENDED") then
SET NEW.memberStatus= "REGULAR";
ELSEIF ((NEW.fine_logging!=0 or NEW.fine_logging is NOT NULL) AND OLD.MemberStatus= "SUSPENDED") then 
if NEW.MemberStatus= "REGULAR" then
set msg ="suspended member didnt clear the fine or this is wrong input";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;
END if;
#this is for error handling part since we cannot set the only who has suspended status
#into regular status
END if;
END IF ;
END //
DELIMITER ;

#question 3: Create a helper trigger overdue helper for converting a member 
#who has more than 30 dollars fines
# and record this change (regular->suspended) into the new table count_status.


DELIMITER //
drop trigger if exists overdue_helper;
CREATE trigger overdue_helper
BEFORE UPDATE ON Member 
FOR EACH ROW
begin
IF NEW.fine_logging>=30 and OLD.MemberStatus= "REGULAR" then

INSERT INTO Count_status(MemberID,MemberStatus,Status_changing_date)
VALUES
(NEW.MemberID,"SUSPENDED",NOW());
END IF;

IF NEW.fine_logging>30 and OLD.MemberStatus= "REGULAR" then
SET NEW.memberStatus= "SUSPENDED";

END IF;
END //
DELIMITER ;

#our procedure will display all rows with the suspended time>=2 and set the member 
#into the status "terminate" when we count the record in "count_status"

DELIMITER //
DROP PROCEDURE if exists overdue_procedure//
CREATE procedure overdue_procedure()
BEGIN
DECLARE v_MemberID INT;
DECLARE v_count INT;
DECLARE v_finish INT default 0;
DECLARE s_memberID INT;
DECLARE s_name VARCHAR(255);
DECLARE s_log Double(10,2);


declare overdue_handler CURSOR FOR 
select count(MemberID),MemberID
from count_status
where NOW()< DATE_ADD(Status_changing_date, INTERVAL 3 YEAR)
group by MemberID
having count(MemberID)>1;

DECLARE CONTINUE HANDLER for not found set v_finish=1;
DECLARE CONTINUE HANDLER for sqlexception
BEGIN 
ROLLBACK;
Select "fail to terminate";
END;

open overdue_handler; 
repeat 
fetch overdue_handler INTO v_count,v_MemberID;

SELECT MemberID,MemberName,fine_logging into s_memberID,s_name,s_log
from Member
where MemberID=v_MemberID;

if s_log>0 then
SELECT s_memberID,s_name;
ELSE 
SIGNAL SQLSTATE "45000";
end if;



UPDATE member
SET MemberStatus="Terminate"
WHERE MemberID=v_MemberID and fine_logging>0;

UNTIL v_finish
END repeat;
CLOSE overdue_handler; 
END//
DELIMITER ;

#create a contraint trigger for the business rule: you cannot borrowed more than 5 books within
#3 weeks


DELIMITER //
drop trigger if exists businessrule;
CREATE trigger businessrule
BEFORE insert ON borrowedby
FOR EACH ROW
begin
Declare v_count INT;
DECLARE msg VARCHAR (255);
select count(memberID) into v_count from borrowedby natural join book
WHERE dateborrowed > date_sub(now(), interval 3 week) and memberID=new.memberID
group by memberID;

if v_count>=5 then
set msg ="you cannot borrorw more than 5 books";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;

END IF;

END //
DELIMITER ;





#create a contraint trigger for the business rule: you cannot borrowed more than one same
#book on the same day

DELIMITER //
drop trigger if exists businessrule_2;
CREATE trigger businessrule_2
BEFORE insert ON borrowedby
FOR EACH ROW
begin
Declare v_count INT;
DECLARE msg VARCHAR (255);
select count(memberID) into v_count from borrowedby natural join book
WHERE memberID=new.memberID and bookID= NEW.BOOKID
group by memberID,dateborrowed;

if v_count>=1 then
set msg ="you cannot borrorw more than 1 same books at the same day";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;
END IF;

END //
DELIMITER ;

#create a contraint trigger: when a book with publisher 3 is inserted into borrrow
#then the table holding must have one book as well since it is in stock for people to borrow
#the trigger also  +1 into instock in Holding

DELIMITER //
drop trigger if exists businessrule_3;
CREATE trigger businessrule_3
AFTER insert ON book
FOR EACH ROW
begin
DECLARE v_count INT;
declare msg TEXT;

select count(BookID) into v_count from BOOK where BOOKID=NEW.BOOKID;
if v_count<=1 then 
INSERT INTO holding(BranchID,BookID,INStock,ONLoan)
VALUES
(3,NEW.BookID,2,0);
else set msg ="wrong:this book is already inserted in the book table";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;
END IF;

END //
DELIMITER ;

#create a contraint trigger for the business rule: you can borrrow a book only if you 
#are regular member

DELIMITER //

drop trigger if exists businessrule_4;
CREATE trigger businessrule_4
BEFORE insert ON borrowedby
FOR EACH ROW
begin
DECLARE v_count INT;
declare msg TEXT;
declare v_id INT;
declare v_status TEXT;
declare v_exp DATE;

select memberID,MemberStatus,MemberExpdate into v_id,v_status,v_exp from Member where
memberID = NEW.MemberID;

if ((v_status!= "REGULAR") or (curdate()>v_exp)) then
set msg ="wrong:this member is not in regular state or the membership library is expired";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;
END IF;

END //
DELIMITER ;



#create business rule: you can borrrow a book if only if there is one copy on hold.

DELIMITER //

drop trigger if exists businessrule_5;

CREATE trigger businessrule_5
BEFORE insert on borrowedby
FOR EACH ROW
begin

declare msg TEXT;
declare v_id INT;
declare v_instock INT;
declare v_loan INT;

select BookID,INSTOCK,ONloan into v_id,v_instock,v_loan from holding where
BookID = new.BOOKID;

if v_instock<=1 then 
set msg ="Error: cannot borrrow because it is not instock";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;
end if;
END //
DELIMITER ;

#Create a trigger to see if the returned date is later than the expiration date
#We cannot borrow a book if this statement is true.

DELIMITER //
drop trigger if exists businessrule_7;

CREATE trigger businessrule_7
BEFORE insert ON borrowedby
FOR EACH ROW
begin
DECLARE v_count INT;
declare msg TEXT;
declare v_id INT;

declare v_exp DATE;

select memberID,MemberExpDate into v_id,v_exp from Member where
memberID = NEW.MemberID;

if (NEW.ReturnDueDate > v_exp) then
set msg ="wrong:the returneDuedate is later than expirationDate";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;
END IF;

END //
DELIMITER ;

#This is the trigger for the same rule but for updating the table.

DELIMITER //
drop trigger if exists businessrule_7_5;

CREATE trigger businessrule_7_5
BEFORE UPDATE ON borrowedby
FOR EACH ROW
begin
DECLARE v_count INT;
declare msg TEXT;
declare v_id INT;

declare v_exp DATE;

select memberID,MemberExpDate into v_id,v_exp from Member where
memberID = NEW.MemberID;

if (NEW.ReturnDueDate > v_exp) then
set msg ="wrong:the returneDuedate is later than expirationDate";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;
END IF;

END //
DELIMITER ;

#This is a herlper function for caluclating the fine for specific member.

DELIMITER //
DROP function if exists count_fine;
CREATE function count_fine(Returned DATE,Return_due DATE)
RETURNS int
DETERMINISTIC 
BEGIN
DECLARE count INT;
IF (Returned IS NULL) and DATEDIFF(curdate(), Return_due)>0 then 
SET count =2*DATEDIFF(curdate(), Return_due);
end if;

IF (Returned IS NOT NULL) and DATEDIFF(Returned,Return_due)>0 then 
SET count =2*DATEDIFF(Returned,Return_due);
end if;

return count;
end //
DELIMITER ;

#This is the procedure to update all fine-logging for all members with overdue fine.

DELIMITER //
DROP PROCEDURE if exists overdue_countfine//
CREATE procedure overdue_countfine()
BEGIN
DECLARE v_MemberID INT;
DECLARE v_sum INT;
DECLARE v_finish INT default 0;

declare countfine CURSOR FOR 
select MEMBERID ,sum(count_fine(DateReturned,ReturnDueDate)) from (member natural join borrowedby)
group by MEMBERID;

DECLARE CONTINUE HANDLER for not found set v_finish=1;

open countfine; 
repeat 
fetch countfine INTO v_MemberID,v_sum;

UPDATE member
SET fine_logging=v_sum
WHERE MemberID = v_MemberID;

UNTIL v_finish
END repeat;
CLOSE countfine; 
END//
DELIMITER ;

#We also need a procedure to turned all member who has expired membership since 
#only regular member can borrowed book:
DELIMITER //
DROP PROCEDURE if exists keep_suspend//
CREATE procedure keep_suspend()
BEGIN
DECLARE v_MemberID INT;
DECLARE v_status TEXT;
DECLARE v_Exp DATE ;
DECLARE v_finish INT default 0;

declare suspend_handler CURSOR FOR 
select MemberID,MemberStatus,MemberExpDate
from Member;
DECLARE CONTINUE HANDLER for not found set v_finish=1;
open suspend_handler; 
repeat 
fetch suspend_handler INTO v_MemberID,v_status,v_Exp;
UPDATE member
SET MemberStatus="SUSPENDED"
WHERE MemberID=v_MemberID and MemberStatus="REGULAR" and (curdate()>v_Exp);

if (curdate()>v_Exp) then
INSERT INTO Count_status(MemberID,MemberStatus,Status_changing_date)
VALUES
(v_MemberID,"SUSPENDED",NOW());
end if;

UNTIL v_finish
END repeat;
CLOSE suspend_handler; 
END//
DELIMITER ;

#We can turned all regular member into suspended member (pass the expiry date)using this code:


call keep_suspend();

#at the same time,the suspended record will be in count_status.

select* from count_status;


#To keep track of the borrow-by and holding table. We created this procedure 
#which I can update the borrrowby and holding at the same time with member,
#BOOKID and date borrowed and date returned(can be NULL):

DELIMITER //
DROP PROCEDURE if exists borrow_holding//
CREATE procedure borrow_holding(in mem_id INT,in BOOK_Id INT,in Date_borr DATE,in date_return DATE)
BEGIN
DECLARE msg VARCHAR (255);
Declare count_bookID INT default -1;
declare in_stock int;
declare on_stock int;
declare branch_id int;
SELECT count(BookID) into count_bookID from Holding where BOOKID=BOOK_Id;
SELECT InStock,branchID,OnLoan into in_stock,branch_id,on_stock from Holding where BOOKID=BOOK_Id;

if count_bookID<1 or count_bookID=NULL or in_stock<1 or branch_id!=3
then set msg ="We cannot borrrow/return it due to error";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;

ELSE 

if date_return is NULL then
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('3', BOOK_Id,mem_id,Date_borr,date_return,date_add(Date_borr,INTERVAL 3 WEEK));

UPDATE Holding
set OnLoan=OnLoan+1 where BookID=BOOK_Id;  
UPDATE Holding
set InStock=InStock-1 where BookID=BOOK_Id;
end if;


if date_return is NOT NULL then

if on_stock>0 then
UPDATE Holding
set OnLoan=OnLoan-1 where BookID=BOOK_Id;

UPDATE Holding
set InStock=InStock+1 where BookID=BOOK_Id;

UPDATE Borrowedby
SET DateReturned = date_return
WHERE BranchID=3 and BOOKID=BOOK_Id and DateBorrowed=Date_borr;

else set msg ="error: on_loan cannot be negative";
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT=msg;
end if;

end if;

END IF;
END//
DELIMITER ;

call borrow_holding(6,9,curdate(),curdate()+1);


#this is our new test datas

INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('7','New_test_book','1','2011',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('8','The peterman_2','1','2012',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('9','The peterman_3','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('10','The peterman_4','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('15','The peterman_6','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('16','The peterman_8','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('17','The peterman_9','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('18','The peterman_10','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('19','The peterman_11','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('20','The peterman_12','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('21','The peterman_13','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('22','The peterman_14','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('23','The peterman_14','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('24','The peterman_14','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('25','The peterman_14','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('26','The peterman_14','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('27','The peterman_15','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('28','The peterman_16','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('29','The peterman_17','2','2009',125.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('30','The peterman_17','2','2009',125.99);






#We can use other tiggers to test whether we violate the business rule above.
#We can see we cannot borrow the book if there is violation as stated in the report.

#These code is to test the trigger,we cannot for than 5 books for the same member within
#3 weeks.

select * from holding;
select * from borrowedby;



select memberID,count(memberID) from borrowedby natural join holding
WHERE dateborrowed > date_sub(now(), interval 3 week) and memberID=15
group by memberID;

#We can see some of them didnt pass the rules because their membership is expired or in regular state.

# We can change the memberexpdate to test the trigger.
select * from borrowedby;

UPDATE member
set MemberExpDate="2025-01-01" where memberID=8;



# To test question2 and3,we can keep changing the fine_logging.
#for question 3 we can see there is record on the table count_status if there is change
#from regular into suspended status.
#-------------question2A-----we use a trigger which is explained in the report;
#We can also use a triggers to do update both tables borrowby and holding in consistent 
# which is called "borrow_holding"
#
#we can test it by applying a new borrrowed record.
call borrow_holding(21,22,curdate(),NULL);
call borrow_holding(21,21,curdate(),NULL);
call borrow_holding(21,19,curdate(),NULL);
call borrow_holding(21,18,curdate(),NULL);
call borrow_holding(21,17,curdate(),NULL);
call borrow_holding(21,20,curdate(),NULL);
call borrow_holding(21,16,curdate(),NULL);


call borrow_holding(15,22,curdate(),NULL);
call borrow_holding(8,16,curdate(),NULL);
call borrow_holding(8,19,curdate(),NULL);
call borrow_holding(13,18,curdate(),"2027-01-23");
call borrow_holding(12,17,curdate(),NULL);
call borrow_holding(12,15,curdate(),NULL);
call borrow_holding(30,29,curdate(),NULL);
call borrow_holding(30,28,curdate(),NULL);
call borrow_holding(26,27,curdate(),NULL);
call borrow_holding(25,25,curdate(),NULL);
call borrow_holding(24,24,curdate(),NULL);
# We return it
#reuturn the book late
call borrow_holding(13,18,curdate(),"2027-10-12");
call borrow_holding(12,17,curdate(),"2027-10-12");
call borrow_holding(6,9,curdate(),"2024-4-30");
call borrow_holding(26,27,curdate(),"2028-4-30");

call borrow_holding(21,17,curdate(),curdate());
#return on time
call borrow_holding(25,25,curdate(),"2023-11-02");
call borrow_holding(23,24,curdate(),"2023-11-02");
-----------------------
#other example
# member12 borrrowed a book number 12
call borrow_holding(12,23,curdate(),NULL
);
#he returned late
call borrow_holding(12,24,curdate(),'2026-11-21'
);
#Since he returned book late,we can count them all
# we runned a procedure to count the fine for all members
#-----also we can test question 1b: test it if the fine_logging column exists or not----
call overdue_countfine();

#all members who have overdue fine will be suspended
select * from member;




#--------in question 2---we can update the member 
#with different values in fine_logging with all test cases we need.


update member   #case one,we test whether the trigger works or not.
set fine_logging=0 where memberID=1;

select * from member;
# We cannot turn a suspened member into regular member if the fine is not cleared yet.
update member
set fine_logging=11 where memberID=2;
UPDATE member
SET memberstatus="REGULAR"
WHERE MemberID = 2;

#set the fine to become negative->error
UPDATE member
set fine_logging=-11 where memberID=2;

select * from member;
#--------------We can see the fine become zero=> become regular again





update member
set fine_logging=122 where memberID=21;
update member
set fine_logging=0 where memberID=12;

#the test case for the error handle(2) : fine cannot be less than 0
select * from member;
update member
set fine_logging=177 where memberID=13;

UPDATE member
SET memberstatus="REGULAR"
WHERE MemberID = 13;

#We can check this failed as well since we cannot have negative fine.
UPDATE member
SET fine_logging=-1
WHERE MemberID = 13;


select * from count_status;

#--------------test the (4) and (5) in regular state:
UPDATE member
SET fine_logging=11
WHERE MemberID = 11;



select * from member
where MemberID=11;

UPDATE member
SET fine_logging=0
WHERE MemberID = 11;



select * from member
where MemberID=11;


# test -case (3) we cannot change a terminate status into regular status

select * from member
where MemberID=1;

UPDATE member
SET fine_logging=0
WHERE MemberID = 1;

# test -case (2) we cannot change a suspened member into regular member without clearing the fine

select * from member where memberID=19;

UPDATE member
SET MemBErstatus="REGULAR"
WHERE MemberID = 19;


#--------in question 3---we can display and update the termination using this code.
#set joe to be suspended twice

update member
set fine_logging=100 where memberID=1;

UPDATE member
SET fine_logging=1111
WHERE MemberID = 26;

UPDATE member
SET fine_logging=0
WHERE MemberID = 26;

UPDATE member
SET fine_logging=111
WHERE MemberID = 26;

UPDATE member
SET fine_logging=1111
WHERE MemberID = 25;

UPDATE member
SET fine_logging=0
WHERE MemberID = 25;



select * from member where MemberID=25 or MemberID=26 or MemberID=1 or MemberID=2 ;

select * from count_status;

call overdue_procedure();

#display the result

select MemberID,MemberStatus,fine_logging from Member;
select * from count_status;

#terminate the member who meets the condition



#we have already reset the member twice and this memeber will be suspended.
call overdue_procedure();

#(test case for question3): to see the error handling case,we notice that the member
#would not be terminate even if he suspended twice.
UPDATE member
SET fine_logging=1111
WHERE MemberID = 9;
UPDATE member
SET fine_logging=0
WHERE MemberID = 9;
UPDATE member
SET fine_logging=1111
WHERE MemberID = 9;
UPDATE member
SET fine_logging=0
WHERE MemberID = 9;

UPDATE member
SET fine_logging=1111
WHERE MemberID = 12;
UPDATE member
SET fine_logging=0
WHERE MemberID = 12;
UPDATE member
SET fine_logging=1111
WHERE MemberID = 12;


select * from member
where MemberID=12;

# (test_case for question 3):this part is to see if the year-range is greater than 3 years
#Then the procedure will not work for those cases.
UPDATE Count_status
SET Status_changing_date="2017-10-28 02:33:53"
WHERE MemberID = 9 and Status_changing_date='2023-10-29 03:04:51';

call overdue_procedure();


#display the result if we test memberID=9
SELECT * from 
member where MemberID=9;

#these codes : We borrorw a book to see if there is violation to the business rules.

INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '2','9','2020-08-30',NULL,date_add('2020-08-30',INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '2','9','2020-08-30',NULL,date_add('2020-08-30',INTERVAL 3 WEEK));

select memberID, ReturnDueDate,MemberExpDate from member natural join borrowedby;

#test the result

select * from borrowedby
where
memberID = 9; 





