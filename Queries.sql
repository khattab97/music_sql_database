/* Query 1 */
WITH t1
AS (SELECT
  a.Title album_title,
  g.name genre,
  COUNT(t.trackid) no_of_tracks
FROM Album a
JOIN Track t
  ON a.AlbumId = t.AlbumId
JOIN Genre g
  ON t.GenreId = g.GenreId
GROUP BY 1,
         2)
SELECT
  t1.genre,
  COUNT(t1.album_title) num_of_albums
FROM t1
GROUP BY 1
ORDER BY 2 DESC LIMIT 10;


/* Query 2 */
SELECT
  g.name genre,
  SUM(il.UnitPrice * il.Quantity) total_selling
FROM InvoiceLine il
JOIN Track t
  ON il.TrackId = t.TrackId
JOIN Genre g
  ON t.GenreId = g.GenreId
GROUP BY 1
ORDER BY 2 DESC LIMIT 5;


/* Query 3 */
SELECT
  a.name,
  SUM(il.UnitPrice * il.Quantity) totalSpent
FROM Artist a
JOIN Album al
  ON a.ArtistId = al.ArtistId
JOIN track t
  ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il
  ON t.TrackId = il.TrackId
GROUP BY 1
ORDER BY 2 DESC LIMIT 10;


/* Query 4 */
WITH t1
AS (SELECT
  a.name,
  SUM(il.UnitPrice) totalSpent
FROM Artist a
JOIN Album al
  ON a.ArtistId = al.ArtistId
JOIN track t
  ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il
  ON t.TrackId = il.TrackId
GROUP BY 1
ORDER BY 2 DESC LIMIT 1),
t2
AS (SELECT
  a.name,
  SUM(il.Quantity * il.UnitPrice) amountSpent,
  c.CustomerId,
  c.FirstName,
  c.LastName
FROM Artist a
JOIN Album al
  ON a.ArtistId = al.ArtistId
JOIN track t
  ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il
  ON t.TrackId = il.TrackId
JOIN Invoice i
  ON il.InvoiceId = i.InvoiceId
JOIN Customer c
  ON i.CustomerId = c.CustomerId
GROUP BY 1,
         3,
         4,
         5)

SELECT
  t2.name artist_name,
  t2.amountSpent,
  t2.CustomerId,
  t2.FirstName,
  t2.LastName
FROM t2
JOIN t1
  ON t2.name = t1.name
ORDER BY 2 DESC LIMIT 10;