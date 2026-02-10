/*
Payment funnel analysis with CTEs
The product manager has requested a payment funnel analysis from the analytics team; she wants to understand what the furthest point in the payment process users are getting to and where users are falling out of the process. She wants to have full visibility into each possible stage of the payment process from the user's point of view.

Here's the payment process a user goes through when signing up for a subscription:
	1. The user opens the widget to initiate payment.
	2. The user types in credit card information.
	3. The user clicks the submit button to complete their part of the payment process.
	4. The product sends the data to the third party payment processing company.
	5. The payment company completes the transaction and reports back with "complete."

The process is converted into statusids that are defined by statusdefinition table.

As subscriptions move through the statuses, the movements are logged in the paymentstatuslog table using the statusid. 
Users can go back and forth and move through statuses multiple times. 

Count the number of subscriptions in each paymentfunnelstage as outlined in the code by incorporating the maxstatus reached and the currentstatus per subscription. 
Use the paymentstatuslog and subscriptions tables.
*/

WITH maxstatusperid AS
        (SELECT
                subscriptionid,
                max(statusID) AS maxstatus,
        FROM
                PaymentStatusLog
        GROUP BY
                subscriptionid
        ),


checkoutfunnel AS
        (SELECT
                s.currentstatus,
                m.maxstatus AS maxstatus,
                CASE 
                        when maxstatus = 1 then 'PaymentWidgetOpened'
                        when maxstatus = 2 then 'PaymentEntered'
                        when maxstatus = 3 and currentstatus = 0 then 'User Error with Payment Submission'
                        when maxstatus = 3 and currentstatus != 0 then 'Payment Submitted'
                        when maxstatus = 4 and currentstatus = 0 then 'Payment Processing Error with Vendor'
                        when maxstatus = 4 and currentstatus != 0 then 'Payment Success'
                        when maxstatus = 5 then 'Complete'
                        when maxstatus is null then 'User did not start payment process'
                END as PaymentFunnelStage		

        FROM
                subscriptions s JOIN maxstatusperid m
                ON s.subscriptionid = m.subscriptionid
        
        GROUP BY
                s.subscriptionid
        )

SELECT
        PaymentFunnelStage,
        count(*) AS Subscriptions
FROM
        checkoutfunnel
GROUP BY
        PaymentFunnelStage