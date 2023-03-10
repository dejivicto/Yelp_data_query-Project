# Yelp_data_query-Project
SELECT b.city AS City,(u.review_count) AS reviews
FROM business b
JOIN user u
ON b.id=u.id
GROUP BY City
ORDER BY reviews DESC
	
