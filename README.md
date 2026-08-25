# mysql-business-rules-engine

# City-145 Library Database Automation (COMP6350 Assignment 3)

Hi there! 👋 This is my full-mark database project for postgraduate Database Systems (COMP6350) in  University. The assignment was all about helping a fictional library ("City-145 Library") automate their manual book loan and penalty tracking processes using MySQL[cite: 1].

I used pure server-side SQL (stored procedures, triggers, custom error handlers, and cursors) to enforce complex business rules without needing application-layer code[cite: 1].

---

## 📌 Project Goals

The library had several manual rules they wanted to automate[cite: 1]:
* Keeping real-time track of inventory (`InStock` vs. `OnLoan`) across branches whenever books are borrowed or returned[cite: 1].
* Automatically calculating late fees ($2/day) and suspending accounts with overdue items or debts over $30[cite: 1].
* Resetting suspended members back to `REGULAR` only after they pay off their full fine balance[cite: 1].
* Auto-terminating repeat offenders (members suspended 2+ times in the last 3 years who still owe fines)[cite: 1].
* Enforcing borrow limits (e.g., max 5 books in 3 weeks, no duplicate borrows on the same day, preventing loans if membership is expired)[cite: 1].

---

## 🛠️ What I Built

### 1. Business Rule Validation Triggers
* **`overdue` Trigger:** A `BEFORE UPDATE` trigger on the `Member` table[cite: 1]. If someone tries to reset a suspended member to regular without clearing their fines, or enters a negative fine amount, it throws an error using `SIGNAL SQLSTATE "45000"`[cite: 1].
* **Loan Validation Triggers:** Blocks book borrow attempts if the member's account is suspended/expired, or if the library branch has 0 copies left in stock[cite: 1].

### 2. Stored Procedures & Functions
* **`overdue_procedure()`:** Uses a **SQL Cursor** to loop through an audit table (`count_status`), finds members suspended multiple times within a 3-year rolling window, checks their fine balances, and updates their status to `Terminate`[cite: 1]. Includes a `CONTINUE HANDLER` for exception rollbacks[cite: 1].
* **`borrow_holding()`:** Handles borrowing and returning books in one go[cite: 1]. It updates the `borrowedby` transaction table and simultaneously increments/decrements branch inventory in `holding`[cite: 1].
* **`count_fine()` & `overdue_countfine()`:** Automatically calculates day-difference penalties using MySQL date functions[cite: 1].

---

## 🧪 Testing & Edge Cases

To make sure everything worked properly (and get full marks on Task 4[cite: 1]), I built a comprehensive test suite covering tricky edge cases[cite: 1]:
* Trying to change account status with uncleared fines (verified error code `1644` triggers)[cite: 1].
* Attempting to insert negative fines[cite: 1].
* Testing 3-year date window boundaries for repeat suspensions[cite: 1].
* Handling borrowing attempts when inventory hits 0 or membership expires before the return due date[cite: 1].

---

## 🧪 Testing & Verification

A structured test harness was implemented to test edge cases[cite: 1]:
* Attempting status resets with pending balances (asserting error code `1644`)[cite: 1].
* Inserting invalid fine amounts (boundary violations)[cite: 1].
* Evaluating 3-year boundary windows for recurring suspensions[cite: 1].
* Validating inventory and date-bound loan constraints[cite: 1].

---

## 📁 Repository Structure

* `45245673.sql` - Complete SQL source file containing table DDL, triggers, stored procedures, and test queries[cite: 1].
* `My final report in assignment 3.pdf` - Project documentation with detailed execution results and test output screenshots[cite: 1].
