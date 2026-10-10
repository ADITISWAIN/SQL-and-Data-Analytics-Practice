# What percentage of phone calls are international? Round the result to 1 decimal.

SELECT ROUND(
    100.0 * COUNT(
        CASE 
            WHEN c.country_id <> r.country_id THEN 1
        END
    ) / COUNT(*),
    1
) AS international_percentage
FROM phone_calls p
JOIN phone_info c
    ON p.caller_id = c.caller_id
JOIN phone_info r
    ON p.receiver_id = r.caller_id;
