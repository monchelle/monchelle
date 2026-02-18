/*
Business problem: Pulling employee/manager data with a self join
The VP of sales is currently contacting all of the managers who have direct reports in the Sales Department to notify them of the new commission structure. 
Using the employees table, which contains all employees and their associated manager, you can pull a report of all sales employees and their manager's email address using a self join. 
However, with your sharp thinking you notice that several employees have null values for their manager's email address due to the fact that some employees don't have a manager logged in the database.

Task:
Create an email list from the employees table that includes the following columns for all employes under department = 'Sales'.
	• employeeid
	• employee_name
	• manager_name
	• contact_email (use the manager email if available and the employee email if not)
*/

SELECT
    employees.employeeid,
    employees.name AS employee_name,
    managers.name AS manager_name,
    CASE 
    WHEN managers.name IS NOT NULL THEN managers.email
    ELSE employees.email
    END AS contact_email

FROM
    Employees  
    LEFT JOIN
    Employees Managers ON
    employees.managerid = managers.employeeid
    
WHERE
    Employees.Department = 'Sales'