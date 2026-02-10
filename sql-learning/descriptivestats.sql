/* Pull Descriptive Statistics with a CTE
The leadership team at your company is making goals for 2023 and wants to understand how much revenue each of the product subscriptions, basic and expert, are generating each month.
More specifically, they want to understand the distribution of monthly revenue across the past year, 2022.

They've asked:
How much revenue does each product usually generate each month?
Which product had the most success throughout all of last year?
Did either product fluctuate greatly each month or what the month-to-month fairly consistent?

Calculate the minimum, maximum, average, and standard deviation of monthly revenue for each product for the year 2022.
This will equip leadership with a quick summary of the revenue and consistency that each product prodvided last year. */

WITH monthly_revenue AS
    (SELECT
        p.ProductName AS ProductName,
        sum(Revenue) as TotalRevenue
    FROM
        Subscriptions s JOIN Products p
		ON s.productid = p.productid
    WHERE
        orderdate BETWEEN '2022-01-01' AND '2023-01-01'
    GROUP BY
        p.ProductName, date_trunc('month', orderdate))


SELECT
	ProductName,
	min(TotalRevenue) as min_rev,
	max(TotalRevenue) as max_rev,
	avg(TotalRevenue) as avg_rev,
	stddev(TotalRevenue) as std_dev_rev
 
FROM
    monthly_revenue

GROUP BY
	ProductName