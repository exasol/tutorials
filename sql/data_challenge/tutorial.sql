/**
now its your turn

1. load data into the tables. Data is stored under the previously defined S3_DATA_CHALLENGE connection.
Files are called customer.csv, item.csv, household_demographics.csv and web_sales.csv
There is a single CSV file per table, files contain a header and are separated by semicolon. 
Rows are terminated by Unix LF, file are UTF-8 encoded
**/


/**
2. Now that we have loaded the data, let's familiarize ourselves and write some queries.
You can find the ER diagram for the data here (2.3.5): https://www.tpc.org/TPC_Documents_Current_Versions/pdf/TPC-DS_v4.0.0.pdf
**/

/**
Q1: Get the first and last name of customers that have at least one vehicle in the household.
Hint: you can join the customer and household data on C_CURRENT_HDEMO_SK = HD_DEMO_SK  
**/


/**
Q2: Now let's refine Q1 and additionally filter down to those customers that had web sales of at least 250$ of list price
Hint: you can join customer and web_sales data on ws_bill_customer_sk=c_customer_sk
**/


/**
Q3: Now let's extend Q3 and add the item category to the order
Hint: you can join web_sales and item data on I_ITEM_SK=I_ITEM_SK
Make sure that the categories returned are NOT NULL
**/


/**
3. Let's apply some Python to the data. Write a Python UDF to determine the Levenshtein distance between two strings.
**/


/**
4. Now let's bring our Python function and Q3 together.
We want to obtain the results from Q3 and want to add a column for the Levenshtein distance between I_CATEGORY and the word "Shoe".
Hint: Make sure to trim I_CATEGORY
**/

/**
5. Final challenge, let's count the results of our previous query that have a Levenshtein distance of 1.
**/


/**
You have mastered the challenge, congratulations!
**/