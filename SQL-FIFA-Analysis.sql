/*
Quries for various insights
*/

SELECT *
FROM Portfolio.dbo.FIFA23_data


--Player Information
SELECT 
	Name, Age, Nationality, Position, Overall, Club, Height, Weight, [Kit Number]
	FROM Portfolio.dbo.FIFA23_data


--1.Players with the highest overall
SELECT Name, Age, Position, Nationality, Club, [Kit Number],Overall AS "Highest overall rating"
	FROM Portfolio.dbo.FIFA23_data
	ORDER BY "Highest overall rating" DESC

	--Top 10 highest overall
	SELECT Top 10 Name, Age, Position, Nationality, Club, [Kit Number], Overall AS "Highest overall rating"
	FROM Portfolio.dbo.FIFA23_data
	ORDER BY "Highest overall rating" DESC


--2.Top 10 players with the highest pontential
SELECT Top 10 Name,  Age, Position, Nationality, Club, [Kit Number], Potential AS "Highest potential rating"
FROM Portfolio.dbo.FIFA23_data
ORDER BY "Highest potential rating" DESC


--3.Number of players in each nationality
SELECT Nationality, COUNT(*) AS "Total players" , ROUND(AVG(Age),2) AS "Average age"
FROM Portfolio.dbo.FIFA23_data
GROUP BY Nationality
HAVING COUNT(*) >= 11
ORDER BY "Total players" DESC

	--Number of players in each club by average age
	SELECT Club, COUNT(*) as "Total Players", ROUND(AVG(Wage),2) AS "Average wage"
	FROM Portfolio.dbo.FIFA23_data
	WHERE Club IS NOT NULL
	GROUP BY Club
	HAVING COUNT(*) >= 11
	ORDER BY "Average wage" DESC


--4.Total player value by club
SELECT Club, SUM(Value) AS "Total player value by club" 
FROM Portfolio.dbo.FIFA23_data
GROUP BY Club
HAVING SUM(Value) > 0.00
ORDER BY "Total player value by club" DESC


--5.Total number of yes and no
ALTER TABLE Portfolio.dbo.FIFA23_data
ADD [Real Face Updated] NVARCHAR(255);

UPDATE Portfolio.dbo.FIFA23_data
SET [Real Face Updated] = CASE 
                             WHEN [Real Face] IS NULL THEN 'No'
                             ELSE [Real Face]
                           END;

SELECT COUNT(ID) AS "Total number of player",
	COUNT(CASE WHEN [Real Face Updated] = 'Yes' THEN 1 END) AS "Total number of yes",
	COUNT(CASE WHEN [Real Face Updated] = 'No' THEN 1 END) AS "Total number of no"
FROM Portfolio.dbo.FIFA23_data

SELECT [Real Face Updated]
FROM Portfolio.dbo.FIFA23_data

--6.Body type
SELECT DISTINCT([Body Type]), COUNT([Body Type]) AS "Body type count"
FROM Portfolio.dbo.FIFA23_data
GROUP BY [Body Type]
ORDER BY "Body type" DESC



--Standadize date
SELECT "Joined Date", Joined
FROM Portfolio.dbo.FIFA23_data

ALTER TABLE FIFA23_data
ADD "Joined Date" Date

UPDATE FIFA23_data
SET "Joined Date" = CAST(Joined AS DATE)


--Delete unused columns
ALTER TABLE FIFA23_data
DROP COLUMN [Real Face], [Joined]

SELECT *
FROM Portfolio.dbo.FIFA23_data








-----------------------------------------------------------------------------

/*
Filters
Internation reputation, Weak foot, Skill moves
*/
--.(filter)
SELECT DISTINCT([Work Rate]), COUNT([Work Rate]) 
FROM Portfolio.dbo.FIFA23_data
GROUP BY [Work Rate]

--.(filter)
SELECT DISTINCT([Preferred Foot]), COUNT([Preferred Foot]) AS "Total number of player"
FROM Portfolio.dbo.FIFA23_data
GROUP BY [Preferred Foot]

--.(filter)
SELECT [Contract Valid Until]
FROM Portfolio.dbo.FIFA23_data
ORDER BY [Contract Valid Until] 
