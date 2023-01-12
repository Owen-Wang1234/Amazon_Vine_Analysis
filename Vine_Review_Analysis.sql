-- Verify that data table is imported properly
SELECT * FROM vine_table LIMIT 20;

-- Filter for reviews with at least twenty votes
SELECT *
INTO popular_reviews
FROM vine_table
WHERE (total_votes >= 20)
ORDER BY review_id ASC;
-- Verify results
SELECT * FROM popular_reviews LIMIT 20;

-- Filter for reviews where at least half of the votes mark them as helpful
SELECT *
INTO helpful_reviews
FROM popular_reviews
WHERE (CAST(helpful_votes AS FLOAT) / CAST(total_votes AS FLOAT) >= 0.5)
ORDER BY review_id ASC;
-- Verify results
SELECT * FROM helpful_reviews LIMIT 20;

-- Get the Vine (paid) reviews
SELECT *
INTO vine_reviews
FROM helpful_reviews
WHERE (vine = 'Y')
ORDER BY review_id ASC;
-- Verify results
SELECT * FROM vine_reviews LIMIT 20;

-- Get the non-Vine (unpaid) reviews
SELECT *
INTO nonvine_reviews
FROM helpful_reviews
WHERE (vine = 'N')
ORDER BY review_id ASC;
-- Verify results
SELECT * FROM nonvine_reviews LIMIT 20;

-- How many helpful reviews are there?
SELECT COUNT(review_id) AS "Helpful Reviews"
FROM helpful_reviews;

-- How many helpful reviews have 5 stars?
SELECT COUNT(review_id) AS "5-Star Helpful Reviews"
FROM helpful_reviews
WHERE (star_rating = 5);

-- What is the percentage?
SELECT ROUND((SELECT COUNT(review_id)
		 FROM helpful_reviews
		 WHERE (star_rating = 5))/
			 (SELECT COUNT(review_id) * 1.00) * 100, 3) AS "5-Star Percentage"
FROM helpful_reviews;

-- How many vine reviews are there?
SELECT COUNT(review_id) AS "Vine Reviews"
FROM vine_reviews;

-- How many vine reviews have 5 stars?
SELECT COUNT(review_id) AS "5-Star vine Reviews"
FROM vine_reviews
WHERE (star_rating = 5);

-- What is the percentage?
SELECT ROUND((SELECT COUNT(review_id)
		 FROM vine_reviews
		 WHERE (star_rating = 5))/
			 (SELECT COUNT(review_id) * 1.00) * 100, 3) AS "5-Star Percentage"
FROM vine_reviews;

-- How many non-vine reviews are there?
SELECT COUNT(review_id) AS "non-Vine Reviews"
FROM nonvine_reviews;

-- How many non-vine reviews have 5 stars?
SELECT COUNT(review_id) AS "5-Star non-vine Reviews"
FROM nonvine_reviews
WHERE (star_rating = 5);

-- What is the percentage?
SELECT ROUND((SELECT COUNT(review_id)
		 FROM nonvine_reviews
		 WHERE (star_rating = 5))/
			 (SELECT COUNT(review_id) * 1.00) * 100, 3) AS "5-Star Percentage"
FROM nonvine_reviews;