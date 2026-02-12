/*
Business problem: Tracking Sales Quota Progress over Time

The sales team works diligently to sell the product, and they have quotas that they must reach in order to earn all of their commission. 
Because these goals are so intimately tied to revenue, the manager of the team wants to track each sales member's performance throughout the year. 

Task:
Calculate the running total of sales revenue, running_total, and the % of quota reached, percent_quota, for each sales employee on each date they make a sale. Use the sales and employees table to pull in and create the following fields:
	• salesemployeeid
	• saledate
	• saleamount
	• quota
	• running_total
	• percent_quota
Order the final outby by salesemployeeid and saledate.
*/

WITH running_total AS(
    SELECT
        SalesEmployeeID,
        SaleDate,
        SaleAmount,
        SUM(saleamount) OVER(PARTITION BY SalesEmployeeID ORDER BY SaleDate) AS Running_Total
    FROM
        Sales
)

SELECT
    r.SalesEmployeeID,
    r.SaleDate,
    r.SaleAmount,
    r.Running_Total,
    CAST(r.Running_Total as FLOAT) / e.Quota AS Percent_Quota
FROM
    running_total r JOIN employees e
    ON r.salesemployeeid = e.EMPLOYEEID
ORDER BY
    r.SalesEmployeeID,
    r.SaleDate