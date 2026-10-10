# Write a query to calculate the percentage of calls that cannot be categorised. Round your answer to 1 decimal place. For example, 45.0, 48.5, 57.7.

WITH CALL AS(
SELECT call_category,COUNT(*)OVER() as S FROM callers)
SELECT ROUND(100.0* COUNT(*)/MAX(S),1) As uncategorised_call_pct 
 FROM CALL WHERE call_category='n/a' or call_category =' ' OR call_category IS NULL;
