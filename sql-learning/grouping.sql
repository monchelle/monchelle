/* 
Create a SQL report that calculates the average spending amount of customers in each city. 

Result:
Your report should include a list containing two columns; City and AverageSpending by customers in those cities.
	• City field contains the names of cities
	• AverageSpending field contains average amount spent by customers
	• State the purpose of the query
	• The list should be in ascending order by city name

Contraints:
	• The table Invoice should be included
	• Invoice should be aliased as i
	• The results must be grouped by city
	• The average amount should be rounded to 2 decimal places
	• Your query syntax should be composed for a MySQL relational database management system
*/

SELECT
	BillingCity AS City,
	round(avg(total),2) AS AverageSpending
	
FROM
	Invoice AS i

GROUP BY
	BillingCity
	
ORDER BY
	BillingCity