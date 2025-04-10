/*
EXASOL DATA CHALLENGE
*/

-- let's create a schema for our data as well as some empty tables
CREATE SCHEMA DATA_CHALLENGE;
CREATE TABLE DATA_CHALLENGE.ITEM (I_ITEM_SK SMALLINT , I_ITEM_ID CHAR(16) , I_REC_START_DATE DATE, I_REC_END_DATE DATE, I_ITEM_DESC VARCHAR(200), I_CURRENT_PRICE DECIMAL(7,2), I_WHOLESALE_COST DECIMAL(7,2), I_BRAND_ID INTEGER, I_BRAND CHAR(50), I_CLASS_ID INTEGER, I_CLASS CHAR(50), I_CATEGORY_ID INTEGER, I_CATEGORY CHAR(50), I_MANUFACT_ID INTEGER, I_MANUFACT CHAR(50), I_SIZE CHAR(20), I_FORMULATION CHAR(20), I_COLOR CHAR(20), I_UNITS CHAR(10), I_CONTAINER CHAR(10), I_MANAGER_ID INTEGER, I_PRODUCT_NAME CHAR(50), DISTRIBUTE BY I_ITEM_SK);
CREATE TABLE DATA_CHALLENGE.CUSTOMER (C_CUSTOMER_SK SMALLINT , C_CUSTOMER_ID CHAR(16) , C_CURRENT_CDEMO_SK SMALLINT, C_CURRENT_HDEMO_SK SMALLINT, C_CURRENT_ADDR_SK SMALLINT, C_FIRST_SHIPTO_DATE_SK SMALLINT, C_FIRST_SALES_DATE_SK SMALLINT, C_SALUTATION CHAR(10), C_FIRST_NAME CHAR(20), C_LAST_NAME CHAR(30), C_PREFERRED_CUST_FLAG CHAR(1), C_BIRTH_DAY INTEGER, C_BIRTH_MONTH INTEGER, C_BIRTH_YEAR INTEGER, C_BIRTH_COUNTRY VARCHAR(20), C_LOGIN CHAR(13), C_EMAIL_ADDRESS CHAR(50), C_LAST_REVIEW_DATE_SK SMALLINT, DISTRIBUTE BY C_CUSTOMER_SK);
CREATE TABLE DATA_CHALLENGE.HOUSEHOLD_DEMOGRAPHICS (HD_DEMO_SK SMALLINT , HD_INCOME_BAND_SK SMALLINT, HD_BUY_POTENTIAL CHAR(15), HD_DEP_COUNT INTEGER, HD_VEHICLE_COUNT INTEGER, DISTRIBUTE BY   HD_DEMO_SK);
CREATE TABLE DATA_CHALLENGE.WEB_SALES (WS_SOLD_DATE_SK SMALLINT, WS_SOLD_TIME_SK SMALLINT, WS_SHIP_DATE_SK SMALLINT, WS_ITEM_SK SMALLINT , WS_BILL_CUSTOMER_SK SMALLINT, WS_BILL_CDEMO_SK SMALLINT, WS_BILL_HDEMO_SK SMALLINT, WS_BILL_ADDR_SK SMALLINT, WS_SHIP_CUSTOMER_SK SMALLINT, WS_SHIP_CDEMO_SK SMALLINT, WS_SHIP_HDEMO_SK SMALLINT, WS_SHIP_ADDR_SK SMALLINT, WS_WEB_PAGE_SK SMALLINT, WS_WEB_SITE_SK SMALLINT, WS_SHIP_MODE_SK SMALLINT, WS_WAREHOUSE_SK SMALLINT, WS_PROMO_SK SMALLINT, WS_ORDER_NUMBER INTEGER , WS_QUANTITY INTEGER, WS_WHOLESALE_COST DECIMAL(7,2), WS_LIST_PRICE DECIMAL(7,2), WS_SALES_PRICE DECIMAL(7,2), WS_EXT_DISCOUNT_AMT DECIMAL(7,2), WS_EXT_SALES_PRICE DECIMAL(7,2), WS_EXT_WHOLESALE_COST DECIMAL(7,2), WS_EXT_LIST_PRICE DECIMAL(7,2), WS_EXT_TAX DECIMAL(7,2), WS_COUPON_AMT DECIMAL(7,2), WS_EXT_SHIP_COST DECIMAL(7,2), WS_NET_PAID DECIMAL(7,2), WS_NET_PAID_INC_TAX DECIMAL(7,2), WS_NET_PAID_INC_SHIP DECIMAL(7,2), WS_NET_PAID_INC_SHIP_TAX DECIMAL(7,2), WS_NET_PROFIT DECIMAL(7,2), DISTRIBUTE BY   WS_ITEM_SK);

-- also let's create a connection to S3
CREATE OR REPLACE CONNECTION S3_DATA_CHALLENGE
TO 'http://exa-data-challenge.s3-eu-central-1.amazonaws.com';

/*
now it's your turn

1. load data into the tables. Data is stored under the previously defined S3_DATA_CHALLENGE connection.
Files are called customer.csv, item.csv, household_demographics.csv and web_sales.csv
There is a single CSV file per table, files contain a header and are separated by semicolon. 
Rows are terminated by Unix LF, file are UTF-8 encoded
*/


/*
2. Now that we have loaded the data, let's familiarize ourselves and write some queries.
You can find the ER diagram for the data here (2.3.5): https://www.tpc.org/TPC_Documents_Current_Versions/pdf/TPC-DS_v4.0.0.pdf
*/

/*
Q1: Get the first and last name of customers that have at least one vehicle in the household.
Hint: you can join the customer and household data on C_CURRENT_HDEMO_SK = HD_DEMO_SK  
*/


/*
Q2: Now let's refine Q1 and additionally filter down to those customers that had web sales of at least 250$ of list price
Hint: you can join customer and web_sales data on ws_bill_customer_sk=c_customer_sk
*/


/*
Q3: Now let's extend Q3 and add the item category to the order
Hint: you can join web_sales and item data on I_ITEM_SK=I_ITEM_SK
Make sure that the categories returned are NOT NULL
*/


/*
3. Let's apply some Python to the data. Write a Python UDF to determine the Levenshtein distance between two strings.
*/


/*
4. Now let's bring our Python function and Q3 together.
We want to obtain the results from Q3 and want to add a column for the Levenshtein distance between I_CATEGORY and the word "Shoe".
Hint: Make sure to trim I_CATEGORY
*/

/*
5. Final challenge, let's count the results of our previous query that have a Levenshtein distance of 1.
*/


/*
You have mastered the challenge, congratulations!
*/
