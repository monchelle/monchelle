/* Challenge: Report average cost by staff
Imagine you work in the movie rental head office doing payment analysis and you want to know if there is any difference between staff members in the average cost of the movies they've rented out in 2006. 

	• Use the sakila database in phpMyAdmin.
	• You're going to look at the payment and staff tables and compare the average cost of the amount column by staff member. 
	• You should limit yourself to 2006, reporting two columns, one containing the full name from the staff table and the other containing the average amount from the payment table. 
	• You should only be reporting two rows because there are only two staff members. 
	• You should be using a number function, date function, and a string function in this query. 
	• You may find it easiest to use table aliases. */

SELECT
        CONCAT(s.first_name,' ',s.last_name),
    avg(p.amount)

FROM
        staff s JOIN payment p ON
    s.staff_id = p.staff_id

WHERE
        YEAR(p.payment_date) = 2006
    
GROUP BY
        s.staff_id;
