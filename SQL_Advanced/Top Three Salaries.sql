#Write a query to display the employee's name along with their department name and salary. In case of duplicates, sort the results of department name in ascending order, then by salary in descending order. If multiple employees have the same salary, then order them alphabetically.

WITH High AS
 (Select employee.name ,employee.salary ,department.department_name FROM employee 
    Join department ON employee.department_id=department.department_id),
 Salary AS 
 (SELECT *,DENSE_RANK()OVER(partition by department_name order by salary desc) 
    As ranked_salary from High)
    
Select department_name,name,salary from Salary where ranked_salary<=3 order by department_name ASC, salary DESC, name ASC ;
