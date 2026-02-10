/*
Creating binary columns with CASE
The product team is launching a new product offering that can be added on top of a current subscription for an increase in the customer's annual fee. 
The sales team has decided that they first want to reach out to a select group of customers to offer the new product and get feedback before offering it to the entire customer base.

They've decided it would be best to reach out to the customers who meet one of the following two conditions:
	1. Have at least 5000 registered users, or
	2. Only have one product subscription

You decide to help out the sales team by providing them a report with all current customers and the number of product subscriptions and registered users they currently have. 
To make it extra easy for the sales team to identify customers that are upsell_opportunity, you also include a binary column that flags the customers that meet one of those conditions.

*/

SELECT
    customerid,
    count(PRODUCTID) as num_products,
    sum(numberofusers) as total_users,
    CASE
    WHEN sum(numberofusers) > 5000 OR count(productid) = 1 then '1' 
    ELSE 0
    END CASE AS upsell_opportunity

FROM
    subscriptions
GROUP BY
    customerid