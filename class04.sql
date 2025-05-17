CREATE TABLE transactions (
    transaction_id INT,
    transaction_date DATE,
    transaction_time TIME,
    transaction_qty INT,
    store_id INT,
    store_location VARCHAR(100),
    product_id INT,
    unit_price DECIMAL(10, 2),
    product_category VARCHAR(50),
    product_type VARCHAR(100),
    product_detail VARCHAR(100)
);

drop table transactions;

-- SQL BASIC COMMANDS

SELECT STORE_LOCATION, COUNT(transaction_id)
FROM transactions
WHERE PRODUCT_CATEGORY = 'Coffee'
GROUP BY 1
ORDER BY 2 ASC 
LIMIT 1;

-- COFFEE SALES ANALYSIS

SELECT * FROM transactions;

-- HOW MANY TRANACTIONS WE MADE AT APRIL 2023

SELECT COUNT(TRANSACTION_ID)
FROM transactions
where transaction_date between '2021-04-01' and '2021-04-30';

-- MOM TRANSACTIONS TREND

SELECT MONTH(transaction_date) AS MONTH, COUNT(transaction_id) AS TRX_COUNT
FROM transactions
GROUP BY 1;

SELECT EXTRACT(MONTH FROM transaction_date) AS MONTH, COUNT(transaction_id) AS TRX_COUNT
FROM transactions
GROUP BY 1;

-- Total Revenue
select sum(unit_price * transaction_qty)
from transactions;

-- product analysis
select product_detail,
count(distinct date(transaction_date)) as count_date,
sum(transaction_qty) as total_quantity_sold,
sum(transaction_qty)/count(distinct date(transaction_date)) as 'Avg order'
from transactions
group by product_detail
order by 4 desc;

-- Average order value
select sum(transaction_qty * unit_price) / count(distinct transaction_id) as AOV
from transactions;

-- HAVING VS WHERE
select product_detail,
count(distinct transaction_id) as TOTAL_TX
from transactions
group by product_detail
HAVING count(distinct transaction_id) >2000
order by 2 desc;

-- LIKE, ILIKE, IN, BETWEEN, IS NULL

SELECT distinct DATE_FORMAT(date(transaction_date), '%y-%m-%d') AS YM
FROM TRANSACTIONS;

-- STR_AGG

SELECT  PRODUCT_CATEGORY, 
GROUP_CONCAT(DISTINCT PRODUCT_TYPE SEPARATOR ',') AS UNDER_PRODUCT_CATEGORY
FROM transactions
GROUP BY 1;

SELECT  PRODUCT_CATEGORY, PRODUCT_TYPE
FROM transactions;


