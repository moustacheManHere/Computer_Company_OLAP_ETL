-- Query 1

use CompAccInc_DWRam
SELECT
    E.FIRST_NAME,
    E.LAST_NAME,
    E.HIRE_DATE AS DATE_HIRED, 
    COUNT(DISTINCT SF.ORDER_KEY) AS NUMBER_OF_ORDERS,
    SUM(SF.QUANTITY) AS QUANTITY_SOLD,
    FORMAT(SUM(SF.QUANTITY * SF.UNIT_PRICE), 'N2') AS SALES_REVENUE,
    FORMAT(ROUND(SUM((SF.UNIT_PRICE - PD.STANDARD_COST) * SF.QUANTITY), 2), 'N2') AS PROFIT
FROM
    SALES_FACT SF
    JOIN EMPLOYEE_DIM E ON SF.EMPLOYEE_KEY = E.EMPLOYEE_KEY
    JOIN PRODUCT_DIM PD ON SF.PRODUCT_KEY = PD.PRODUCT_KEY
WHERE
    E.JOB_TITLE = 'Sales Representative' 
GROUP BY
    E.FIRST_NAME,
    E.LAST_NAME,
    E.HIRE_DATE 
ORDER BY CAST(REPLACE(FORMAT(ROUND(SUM((SF.UNIT_PRICE - PD.STANDARD_COST) * SF.QUANTITY), 2), 'N2'), ',', '') AS DECIMAL(18, 2)) DESC;

-- Query 2

WITH base_query AS (
    SELECT 
        T.TIME_YEAR AS Year,
        T.TIME_QUARTER AS Quarter,
		COUNT(S.ORDER_KEY) AS Total_No_Of_Orders,
        SUM((S.UNIT_PRICE - P.STANDARD_COST) * S.QUANTITY) AS Total_Profit,
		COUNT(DISTINCT CASE WHEN P.CATEGORY_NAME = 'CPU' THEN S.ORDER_KEY END) AS No_Of_CPU_Orders,
        SUM(CASE WHEN P.CATEGORY_NAME = 'CPU' THEN (S.UNIT_PRICE - P.STANDARD_COST) * S.QUANTITY ELSE 0 END) AS CPU_Profit,
		COUNT(DISTINCT CASE WHEN P.CATEGORY_NAME = 'Mother Board' THEN S.ORDER_KEY END) AS No_Of_Motherboard_Orders,
        SUM(CASE WHEN P.CATEGORY_NAME = 'Mother Board' THEN (S.UNIT_PRICE - P.STANDARD_COST) * S.QUANTITY ELSE 0 END) AS Motherboard_Profit,
		COUNT(DISTINCT CASE WHEN P.CATEGORY_NAME = 'Storage' THEN S.ORDER_KEY END) AS No_Of_Storage_Orders,
        SUM(CASE WHEN P.CATEGORY_NAME = 'Storage' THEN (S.UNIT_PRICE - P.STANDARD_COST) * S.QUANTITY ELSE 0 END) AS Storage_Profit,
		COUNT(DISTINCT CASE WHEN P.CATEGORY_NAME = 'Video Card' THEN S.ORDER_KEY END) AS No_Of_Video_Card_Orders,
        SUM(CASE WHEN P.CATEGORY_NAME = 'Video Card' THEN (S.UNIT_PRICE - P.STANDARD_COST) * S.QUANTITY ELSE 0 END) AS Video_Card_Profit
    FROM 
        SALES_FACT S
    JOIN 
        TIME_DIM T ON S.TIME_KEY = T.TIME_KEY
    JOIN 
        PRODUCT_DIM P ON S.PRODUCT_KEY = P.PRODUCT_ID
    GROUP BY 
        T.TIME_YEAR,
        T.TIME_QUARTER
)
SELECT 
    Year,
    Quarter,
	CONCAT(FORMAT(ROUND(((Total_Profit - LAG(Total_Profit, 1) OVER (ORDER BY Year, Quarter)) / NULLIF(LAG(Total_Profit, 1) OVER (ORDER BY Year, Quarter), 0)) * 100, 2), 'N2'), '%') AS Total_Profit_Growth,
    CONCAT(FORMAT(ROUND(((CPU_Profit - LAG(CPU_Profit, 1) OVER (ORDER BY Year, Quarter)) / NULLIF(LAG(CPU_Profit, 1) OVER (ORDER BY Year, Quarter), 0)) * 100, 2), 'N2'), '%') AS CPU_Profit_Growth,
    CONCAT(FORMAT(ROUND(((Motherboard_Profit - LAG(Motherboard_Profit, 1) OVER (ORDER BY Year, Quarter)) / NULLIF(LAG(Motherboard_Profit, 1) OVER (ORDER BY Year, Quarter), 0)) * 100, 2), 'N2'), '%') AS Motherboard_Profit_Growth,
    CONCAT(FORMAT(ROUND(((Storage_Profit - LAG(Storage_Profit, 1) OVER (ORDER BY Year, Quarter)) / NULLIF(LAG(Storage_Profit, 1) OVER (ORDER BY Year, Quarter), 0)) * 100, 2), 'N2'), '%') AS Storage_Profit_Growth,
    CONCAT(FORMAT(ROUND(((Video_Card_Profit - LAG(Video_Card_Profit, 1) OVER (ORDER BY Year, Quarter)) / NULLIF(LAG(Video_Card_Profit, 1) OVER (ORDER BY Year, Quarter), 0)) * 100, 2), 'N2'), '%') AS Video_Card_Profit_Growth,
    Total_No_Of_Orders,
    CONCAT('$', FORMAT(ROUND(Total_Profit, 2), 'N2')) AS Total_Profit,
    No_Of_CPU_Orders,
    CONCAT('$', FORMAT(ROUND(CPU_Profit, 2), 'N2')) AS CPU_Profit,
    No_Of_Motherboard_Orders,
    CONCAT('$', FORMAT(ROUND(Motherboard_Profit, 2), 'N2')) AS Motherboard_Profit,
    No_Of_Storage_Orders,
    CONCAT('$', FORMAT(ROUND(Storage_Profit, 2), 'N2')) AS Storage_Profit,
    No_Of_Video_Card_Orders,
    CONCAT('$', FORMAT(ROUND(Video_Card_Profit, 2), 'N2')) AS Video_Card_Profit
FROM 
    base_query
ORDER BY 
    Year,
    Quarter;

-- Query 3
USE CompAccInc_DWRam;
WITH QuarterOrders AS (
    SELECT
        T.TIME_YEAR,
        T.TIME_QUARTER,
        COUNT(DISTINCT O.ORDER_ID) AS Orders_In_Quarter
    FROM ORDERS_DIM O
    JOIN TIME_DIM T ON O.ORDER_DATE = CAST(T.TIME_KEY AS DATE)
    GROUP BY T.TIME_YEAR, T.TIME_QUARTER
),
QuarterProducts AS (
    SELECT
        T.TIME_YEAR,
        T.TIME_QUARTER,
        SUM(S.QUANTITY) / COUNT(DISTINCT O.ORDER_ID) AS Avg_Products_Per_Order
    FROM ORDERS_DIM O
    JOIN SALES_FACT S ON O.ORDER_ID = S.ORDER_KEY
    JOIN PRODUCT_DIM P ON S.PRODUCT_KEY = P.PRODUCT_KEY
    JOIN TIME_DIM T ON O.ORDER_DATE = CAST(T.TIME_KEY AS DATE)
    GROUP BY T.TIME_YEAR, T.TIME_QUARTER
),
QuarterStatus AS (
    SELECT
        T.TIME_YEAR,
        T.TIME_QUARTER,
        ROUND(CAST(SUM(CASE WHEN O.ORDER_STATUS = 'Pending' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100,0) AS Pending_Percentage,
        ROUND(CAST(SUM(CASE WHEN O.ORDER_STATUS = 'Canceled' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100,0) AS Cancel_Percentage,
        ROUND(CAST(SUM(CASE WHEN O.ORDER_STATUS = 'Shipped' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 0) AS Shipped_Percentage
    FROM ORDERS_DIM O
    JOIN TIME_DIM T ON O.ORDER_DATE = CAST(T.TIME_KEY AS DATE)
    GROUP BY T.TIME_YEAR, T.TIME_QUARTER
),
QuarterProductSales AS (
    SELECT
        T.TIME_YEAR,
        T.TIME_QUARTER,
        P.PRODUCT_NAME,
        SUM(S.QUANTITY) AS Total_Sold,
        ROW_NUMBER() OVER (PARTITION BY T.TIME_YEAR, T.TIME_QUARTER ORDER BY SUM(S.QUANTITY) DESC) AS PopularityRank
    FROM SALES_FACT S
    JOIN PRODUCT_DIM P ON S.PRODUCT_KEY = P.PRODUCT_KEY
    JOIN TIME_DIM T ON S.TIME_KEY = T.TIME_Key
    GROUP BY T.TIME_YEAR, T.TIME_QUARTER, P.PRODUCT_NAME
)
SELECT
    QO.TIME_YEAR,
    'Q' + CAST(QO.TIME_QUARTER AS VARCHAR) AS Quarter,
    QO.Orders_In_Quarter,
    QP.Avg_Products_Per_Order,
    QS.Pending_Percentage,
    QS.Shipped_Percentage,
	QS.Cancel_Percentage,
    QPS.PRODUCT_NAME AS Most_Popular_Product,
    QPS.Total_Sold AS Most_Popular_Product_Sales
FROM QuarterOrders QO
JOIN QuarterProducts QP ON QO.TIME_YEAR = QP.TIME_YEAR AND QO.TIME_QUARTER = QP.TIME_QUARTER
JOIN QuarterStatus QS ON QO.TIME_YEAR = QS.TIME_YEAR AND QO.TIME_QUARTER = QS.TIME_QUARTER
JOIN QuarterProductSales QPS ON QO.TIME_YEAR = QPS.TIME_YEAR AND QO.TIME_QUARTER = QPS.TIME_QUARTER AND QPS.PopularityRank = 1
ORDER BY QO.TIME_YEAR, QO.TIME_QUARTER;

-- Query 4
with customer_order as (
    select
        c.CUSTOMER_NAME as cust_name,
        s.QUANTITY * (s.UNIT_PRICE - p.STANDARD_COST) as total_margin,
        p.CATEGORY_NAME as cat_name,
        p.PRODUCT_NAME as prod_name
    from CUSTOMER_DIM c, SALES_FACT s, PRODUCT_DIM p, orderS_DIM o
    where c.CUSTOMER_KEY = s.CUSTOMER_KEY and p.PRODUCT_KEY = s.PRODUCT_KEY and o.order_key = s.order_key
),
customer_cat_ranked as (
    select
        cust_name,
        cat_name,
        sum(total_margin) as highest_cat_margin,
        rank() over (partition by cust_name order by sum(total_margin) desc) as cat_ranking
    from customer_order
    group by cust_name, cat_name
),
customer_prod_ranked as (
    select
        cust_name,
        prod_name,
        sum(total_margin) as highest_prod_margin,
        rank() over (partition by cust_name order by sum(total_margin) desc) as prod_ranking
    from customer_order
    group by cust_name, prod_name
),
customer_total_margin as (
    select cust_name, sum(total_margin) as overall_margins
    from customer_order
    group by cust_name
)
select
    ccr.cust_name,
    ccr.cat_name as 'Most valuable category',
    ccr.highest_cat_margin / ctm.overall_margins * 100 as '% of margin of most valuable category',
    cpr.prod_name as 'Most valuable product',
    cpr.highest_prod_margin / ctm.overall_margins * 100 as '% of margin of most valuable product',
    ctm.overall_margins as 'Total profit margin'
from customer_cat_ranked ccr, customer_total_margin ctm, customer_prod_ranked cpr
where ccr.cat_ranking = 1 and cpr.prod_ranking = 1 and ccr.cust_name = ctm.cust_name and cpr.cust_name = ctm.cust_name
order by 'Total profit margin' DESC;

-- Query 5

USE CompAccInc_DWRam;
with wrangling as (
    select 
        p.CATEGORY_NAME,
        avg(coalesce(p.STOCK, 0)) AS stock,
        sum(coalesce(s.QUANTITY, 0) * (coalesce(s.UNIT_PRICE, 0) - p.STANDARD_COST)) as profit_margin,
        sum(coalesce(s.QUANTITY, 0)) as sales
    FROM 
    PRODUCT_DIM p
    LEFT JOIN 
    SALES_FACT s ON p.PRODUCT_KEY = s.PRODUCT_KEY
    group by p.PRODUCT_NAME, p.PRODUCT_ID, p.CATEGORY_NAME
)
select 
    CATEGORY_NAME, 
    avg(stock) as 'Average stock', 
    case when avg(stock) < 200 then 'Low stock' when avg(stock) < 500 then 'Medium stock' else 'High stock' end as 'Average stock status',
    avg(profit_margin) as 'Average profit',
    case when avg(profit_margin) < 20000 then 'Low profit' when avg(profit_margin) < 50000 then 'Medium profit' else 'High profit' end as 'Average profit status',
    avg(sales) as 'Average sales',
    case when avg(sales) < 100 then 'Low sales' when avg(sales) < 200 then 'Medium sales' else 'High sales' end as 'Average sales status'
from wrangling
group by CATEGORY_NAME;
