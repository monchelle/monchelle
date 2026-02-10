/*
Business problem: Analyzing Subscription Cancelation Reasons
Since the chief growth officer is tackling churn next year, one of her big questions is: "why are users canceling and not renewing their subscriptions?" 
Knowing why users aren't renewing their subscriptions will be a key insight into how to prevent churn in the future. 

When users decide to cancel their subscription, they're able to select up to three reasons for canceling out of a preset list. 
Users can't select the same reason twice, and some users may even select less than three reasons and have null values in some of the cancellation reason column. 
Since the economy has been tough lately, you decide to first pull the percent of cancelled subscriptions that cancelled due to the product being too expensive.

Task:
Using UNION and the cancelations table, calculate the percentage of canceled subscriptions that reported 'Expensive' as one their cancelation reasons.

*/
WITH all_cancelation_reasons AS(
SELECT
    subscriptionid,
    cancelationreason1 AS cancelationreason
FROM
    Cancelations
WHERE
    cancelationreason1 IS NOT NULL

UNION

SELECT
    subscriptionid, 
    cancelationreason2 AS cancelationreason
FROM
    Cancelations
WHERE
    cancelationreason2 IS NOT NULL

UNION

SELECT
    subscriptionid,
    cancelationreason3 AS cancelationreason
FROM
    Cancelations
WHERE
    cancelationreason3 IS NOT NULL
)

select 
    cast(count(
        case when cancelationreason = 'Expensive' 
        then subscriptionid end) as float)
    /count(distinct subscriptionid) as percent_expensive
from    
    all_cancelation_reasons