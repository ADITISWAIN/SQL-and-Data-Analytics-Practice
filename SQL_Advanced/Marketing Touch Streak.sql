# As a Data Analyst on Snowflake's Marketing Analytics team, your objective is to analyze customer relationship management (CRM) data and identify contacts that satisfy two conditions:
-Contacts who had a marketing touch for three or more consecutive weeks.
-Contacts who had at least one marketing touch of the type 'trial_request'.

WITH consecutive_streaks AS (
  SELECT 
    contact_id, 
    event_type, 
    event_date, 
    (extract(week from event_date) - 
      row_number() over (
        partition by contact_id 
        order by event_date
    )) as touch_point_streak
  FROM marketing_touches
),
streaks_qualifers as (
  SELECT 
    contact_id
  FROM consecutive_streaks
  GROUP BY contact_id, touch_point_streak
  HAVING count(*) >= 3
),
trial_qualifiers AS (
  SELECT contact_id
  FROM marketing_touches
  WHERE event_type = 'trial_request'
)
SELECT b.email 
FROM streaks_qualifers a INNER JOIN  crm_contacts b
on a.contact_id = b.contact_id 
INNER JOIN trial_qualifiers c 
on b.contact_id = c.contact_id
order by b.email;
