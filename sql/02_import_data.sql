CREATE TABLE bank_customers (
    customer_id       BIGINT PRIMARY KEY,
    credit_score      INT,
    country           VARCHAR(50),
    gender            VARCHAR(10),
    age               INT,
    tenure            INT,
    balance           DECIMAL(15, 2),
    products_number   INT,
    credit_card       INT,
    active_member     INT,
    estimated_salary  DECIMAL(15, 2),
    churn             INT
);



SELECT * FROM bank_customers LIMIT 5;