OPEN SCHEMA RETAIL;
-- DISTRIBUTE SALES_POSITIONS and SALES by sales_id, which is our join column
ALTER TABLE SALES_POSITIONS DISTRIBUTE BY SALES_ID;
ALTER TABLE SALES DISTRIBUTE BY SALES_ID;

-- Verify if tables are well distributed
SELECT iproc(), count(*) FROM sales_positions GROUP BY iproc();
SELECT iproc(), count(*) FROM sales GROUP BY iproc();

-- Enable profiling
ALTER SESSION SET PROFILE = 'on';

-- Run first query
SELECT SUM(sp.amount) FROM SALES s JOIN sales_positions sp ON S.sales_id = sp.sales_id WHERE sales_date = '2015-03-05';

FLUSH STATISTICS;

-- Show query details
SELECT * FROM EXA_USER_PROFILE_LAST_DAY WHERE session_id=current_session AND stmt_id=current_statement-4;

-- Run second query
SELECT S.market_id, SUM(P.amount) AS total_amount FROM SALES_POSITIONS P JOIN SALES S ON P.sales_id = S.sales_id GROUP BY S.market_id;

FLUSH STATISTICS;

-- Show query details
SELECT * FROM EXA_USER_PROFILE_LAST_DAY WHERE session_id=current_session AND stmt_id=current_statement-4;

