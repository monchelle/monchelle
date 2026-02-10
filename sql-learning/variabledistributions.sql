/*
Explore variable distributions with CTEs
A manager on the marketing team comes to you to ask about the performance of their recent email campaign. Now that the campaign has been launched, the marketing manager wants to know how many users have clicked the link in the email.

While this project was being planned, you collaborated with the front-end engineers to create tracking events for the front end of the products located in the frontendeventlog table. \
One of those evens, eventid = 5, is logged when the user reaches a unique landing page that is only accessed from this campaign email, tracking eventid = 5 will be the best method to count how many users have clicked the link in the campaign email.

Since an overall aggregate metric like an average can hide outliers and further insights under the hood, you decide it's best to calculate the distribution of the number of email link clicks per user. 
In other words, how many users clicked the email link one time, two times, three times, and so on?
*/

WITH link_clicks AS (
SELECT
    UserID,
    count(eventID) as num_link_clicks
FROM
    FrontendEventLog
WHERE
    eventID = 5
GROUP BY
    UserID)

SELECT
    num_link_clicks,
    count(userID) as num_users

FROM
    link_clicks

GROUP BY
    num_link_clicks

ORDER BY
    num_link_clicks