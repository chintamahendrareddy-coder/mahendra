-- Run this in Railway PostgreSQL Database tab
-- Press Command+Enter to execute

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    father_name VARCHAR(100),
    mother_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    aadhar_no VARCHAR(12),
    pan_no VARCHAR(10),
    address TEXT,
    balance DECIMAL(10,2) DEFAULT 0.00,
    civil_score INT DEFAULT 0,
    loan_amount DECIMAL(10,2) DEFAULT 0.00,
    loan_paid DECIMAL(10,2) DEFAULT 0.00,
    loan_status VARCHAR(20) DEFAULT 'NONE',
    loan_date VARCHAR(20),
    pay_date VARCHAR(20)
);
