# Yelp_data_query-Project
--1. List the cities with the most reviews in descending order
SELECT b.city AS City,(u.review_count) AS reviews
FROM business b
JOIN user u
ON b.id=u.id
GROUP BY City
ORDER BY reviews DESC
--2a Find the distribution of star ratings to the business in the following cities: Avon
SELECT DISTINCT stars AS star_ratings,COUNT(stars) AS ratings_count
FROM business
WHERE city="Avon"
GROUP BY star_ratings
--2b Find the distribution of star ratings to the business in the following cities: Beachwood
SELECT DISTINCT stars AS star_ratings,COUNT(stars) AS ratings_count
FROM business
WHERE city="Beachwood"
GROUP BY star_ratings
--3. Find the top 3 users based on their total number of reviews:
SELECT name,review_count
FROM user
GROUP BY name
ORDER BY review_count DESC
LIMIT 3
--4. Are there more reviews with the word "love" or with the word "hate" in them?
SELECT COUNT(text)
FROM review
WHERE text LIKE "%Love%"    
UNION
SELECT  COUNT(text)
FROM review
WHERE text LIKE "%Hate%"
--5. Find the top 10 users with the most fans
SELECT id,name,SUM(fans) AS num_fans
FROM user
GROUP BY id
ORDER BY num_fans DESC
LIMIT 10
--6. Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars.
SELECT name, stars,category,b.review_count,
CASE
      WHEN stars BETWEEN 2.0 AND 3.0 THEN "Low"
      WHEN stars >=4.0 THEN "High"
ELSE "No category"
END AS "Quality"
FROM business b
JOIN category c
ON b.id=c.business_id
WHERE city="Toronto" AND category="Restaurants"
ORDER BY stars DESC
--7 Group business based on the ones that are open and the ones that are closed. Find two differences between the two categories
SELECT is_open,COUNT(*) AS Numbers,AVG(stars) AS star_avg,SUM(review_count),
CASE
    WHEN is_open=1 THEN "Opened"
    WHEN is_open=0 THEN "Closed"
    ELSE "No business" 
END AS "Availability"
FROM business 
GROUP BY Availability
--8. Analysis around the commonalities in business categories
SELECT DISTINCT category, COUNT(*),SUM(review_count),AVG(stars) AS star_rating
FROM category c
JOIN business b
ON c.business_id=b.id
GROUP BY category
HAVING star_rating  > 4.0
ORDER BY star_rating DESC


	
