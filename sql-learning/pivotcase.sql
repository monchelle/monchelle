/*
Business problem: Tracking user activity with frontend events
The design team recently redesigned the customer support page on the website, and they want to run an AB test to see how the newly designed page performs compared to the original. 
An AB test is a statistical test used frequently in data science to measure the impact changes have on specified metrics. 
The users will be randomly assigned into two groups: control and treatment. 
The users in control group will see the current customer support page, and the users in treatment will see the new page design. 
The analytics team needs to track user activity via frontend events (button click, page viewing, etc.) to inform the product team for future iterations. 
At the end of the experiment, the results of the control and treatment group will be compared to make a final product recommendation.

You decide that it will be important to track user activity and ticket submissions on the customer support page since they could be impacted, either positively or negatively, by the design changes. 
You choose the following events to track:
	• When a user views the help center page: ViewHelpCenterPage
	• When a user clicks on the FAQs link: ClickedFAQs
	• When a user clicks the contact customer support button: ClickedContactSupport
	• When a user clicks the submit ticket button: SubmittedTicket

Using the FrontEndEventLog table and CASE, count the number of times a user completes the following events:
	• ViewedHelpCenterPage (eventid = 1)
	• ClickedFAQs (eventid = 2)
	• ClickedContactSupport (eventid = 3)
	• SubmittedTicket (eventid = 4)
	• Filter the events with eventtype = 'Customer Support' from the frontevendeventdefinitions table to pull on the events related to customer support.
*/

SELECT
    userid,
    sum(
        CASE
        WHEN eventid = 1 THEN 1
        ELSE 0
        END
    ) AS ViewedHelpCenterPage,
    sum(
        CASE
        WHEN eventid = 2 THEN 1
        ELSE 0
        END
    ) AS ClickedFAQs,
    sum(
        CASE
        WHEN eventid = 3 THEN 1
        ELSE 0
        END
    ) AS ClickedContactSupport,
    sum(
        CASE
        WHEN eventid = 4 THEN 1
        ELSE 0
        END
    ) AS SubmittedTicket
FROM
    FrontendEventLog

WHERE
    eventid IN (1, 2, 3, 4)
GROUP BY
    userid
