# City-145 Library Database Automation (COMP6350 Assignment 3)

Hi there! 👋 This repository contains my **postgraduate Database Systems (COMP6350) Assignment 3** project, implementing a fictional **City-145 Library** database using **MySQL**.

The project focuses on automating library lending, inventory, overdue-fine, membership, and penalty-management rules directly at the database level. The implementation uses **stored procedures, triggers, SQL functions, cursors, and SQL error handling** to enforce business rules and validate library operations.

---

## 📌 Project Goals

The system implements and tests several core library business rules:

* Maintaining consistency between `InStock` and `OnLoan` quantities when books are borrowed and returned.
* Calculating overdue fines at **$2 per overdue day**.
* Automatically changing members to `SUSPENDED` when their accumulated fine exceeds the suspension threshold.
* Preventing suspended members from being incorrectly changed back to `REGULAR` while they still have outstanding fines.
* Identifying members who have been suspended **at least twice within a three-year period** and terminating them when they still have outstanding fines.
* Enforcing borrowing restrictions, including:

  * a maximum of **5 borrowed items within a 3-week (21-day) period**;
  * preventing a member from borrowing the same book more than once on the same day;
  * allowing borrowing only for `REGULAR` members;
  * preventing borrowing after membership expiration;
  * preventing borrowing when the required book stock is unavailable.
* Ensuring that a book's return due date does not exceed the member's membership expiration date.

---

## 🛠️ Implementation Highlights

### 1. Business Rule Validation with Triggers

The **`overdue` trigger** is a `BEFORE UPDATE` trigger on the `Member` table. It:

* rejects negative fine values using `SIGNAL SQLSTATE '45000'`;
* prevents a suspended member from being changed to `REGULAR` while an outstanding fine remains;
* automatically restores a suspended member to `REGULAR` when their fine is cleared.

A separate **`overdue_helper` trigger** records suspension events in the `Count_status` table and changes a regular member to `SUSPENDED` when the fine exceeds the suspension threshold.

Additional triggers on `Borrowedby` enforce borrowing restrictions such as member status, membership expiration, borrowing limits, duplicate same-day borrowing, and book availability.

---

### 2. Stored Procedures, Functions & Cursors

#### `overdue_countfine()`

Uses a SQL cursor to calculate and update overdue fines for members based on the difference between the return due date and either the actual return date or the current date.

The helper function **`count_fine()`** calculates overdue penalties at **$2 per day**.

#### `borrow_holding()`

Coordinates updates between `Borrowedby` and `Holding` when a book is borrowed or returned, updating `InStock` and `OnLoan` accordingly.

#### `keep_suspend()`

Checks membership expiration dates and changes expired `REGULAR` members to `SUSPENDED`, while recording the suspension event in `Count_status`.

#### `overdue_procedure()`

Uses a **SQL cursor and exception handling** to examine suspension records in `Count_status`. It identifies members with more than one suspension within a three-year window and terminates those who still have an outstanding fine.

---

## 🧪 Testing & Verification

A structured set of test cases was used to verify the database business rules and edge cases, including:

* attempting to restore a suspended member to `REGULAR` while an outstanding fine remains;
* attempting to assign a negative fine;
* clearing a suspended member's fine and verifying the resulting status;
* testing repeated suspensions within and outside the three-year window;
* testing termination of repeat offenders with outstanding fines;
* testing the maximum five-book borrowing restriction;
* testing duplicate same-day borrowing of the same book;
* testing borrowing by suspended or expired members;
* testing borrowing when book stock is unavailable;
* testing return due dates against membership expiration dates;
* testing consistency between `Borrowedby` and `Holding`.

The final report documents these test cases and their observed results.

---

## 📁 Repository Structure

* **`45245673.sql`** — Complete MySQL source code containing table definitions, sample data, triggers, functions, stored procedures, and test cases.
* **`My final report in assignment 3.pdf`** — Project report documenting the database design, implementation approach, test cases, and execution results.

---

## 🎯 Key Database Concepts Demonstrated

This project demonstrates practical use of:

* MySQL DDL and DML
* Primary and foreign keys
* Database constraints
* Stored procedures
* Stored functions
* Triggers
* SQL cursors
* `SIGNAL SQLSTATE` error handling
* `CONTINUE HANDLER`
* Business-rule enforcement
* Referential integrity
* Database-level validation
* Automated inventory consistency
* Test-case design and verification

