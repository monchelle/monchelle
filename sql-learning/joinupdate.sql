/* Challenge: Update the film table using JOIN
You've noticed the release year column in the film table is wrong. It should contain the year from the last update column of the film category table. To fix this mistake, you need to set the release year column from the film table to be the year of the last update column in the film category table. This is your challenge and it will require two things:
	1. You will need to join two tables together
	2. You will need to use a function in your query because release year and last update have different data types */

UPDATE film f
JOIN film_category fc
ON f.film_id = fc.film_id
SET f.release_year = YEAR(fc.last_update)
