/* Code Challenge
Red30 Tech is looking to optimize their inventory and marketing strategy by focusing on tracks that haven't been selling well. Your missing involves diving into the database to identify these tracks, offering insights that could guide decisions on promotions or discontinuations.

Your Task:
Write a SQL query that identifies tracks that have never been sold. Your query should return a list of these tracks, along with their composers and the genre.

Result:
Your report should include: a list that includes the Track ID, Track Name, Composer, and Genre for each track that has never been sold.
	• Track ID field shows a unique number for each track
	• Track Name field lists the titles of songs or pieces of music
	• Composer field mentions who created the music
	• Genre field indicates the style or category of the music, like rock or classical
	• The results should be ordered by Track Name in ascending order */

SELECT
    t.TrackId AS "Track ID",
    t.Name AS "Track Name",
    t.Composer,
    g.Name AS Genre


FROM 
    Track AS t

LEFT OUTER JOIN
    Genre AS g

ON
    t.GenreId = g.GenreId

WHERE
    t.TrackId

NOT IN
(SELECT
    DISTINCT
    TrackId

FROM
    InvoiceLine AS li)

ORDER BY
	t.Name