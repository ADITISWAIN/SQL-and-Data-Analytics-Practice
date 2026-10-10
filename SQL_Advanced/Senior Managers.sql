#Output the senior manager's name and the count of their direct reports. The senior manager with the most direct reports should be the first result.

SELECT
  e2.manager_name AS manager_name,
  COUNT(DISTINCT e2.emp_id) AS direct_report_count
FROM employees e1
JOIN employees e2
  ON e1.manager_id = e2.emp_id
JOIN employees e3
  ON e2.manager_id = e3.emp_id
GROUP BY 1
ORDER BY 2 DESC
