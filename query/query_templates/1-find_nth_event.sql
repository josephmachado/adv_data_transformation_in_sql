/**
* Assume we have a `clickstream` table with user_id and the time they clicked on our web page. We can use ranking functions to pick the user's 3rd (or any n-th) click.

* n-th event is a series of events that is beneficial in
	* Marketing attribution
	* Debugging issues with late-arriving data
**/

WITH clickstream AS (
    SELECT
        1 AS user_id, '2024-07-01 10:00:00' AS click_time UNION ALL
    SELECT
        1 AS user_id, '2024-07-01 10:05:00' AS click_time UNION ALL
    SELECT
        1 AS user_id, '2024-07-01 10:10:00' AS click_time UNION ALL
    SELECT
        2 AS user_id, '2024-07-01 10:15:00' AS click_time UNION ALL
    SELECT
        2 AS user_id, '2024-07-01 10:20:00' AS click_time UNION ALL
    SELECT
        2 AS user_id, '2024-07-01 10:25:00' AS click_time
),
ranked_clicks AS (
    SELECT
        user_id,
        click_time,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY click_time) AS click_rank
    FROM
        clickstream
)
SELECT
    user_id,
    click_time,
    click_rank
FROM
    ranked_clicks
WHERE
    click_rank = 3;


