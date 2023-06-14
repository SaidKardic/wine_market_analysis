--Top 10 wines
SELECT id, name, ratings_average, ratings_count
FROM wines 
WHERE ratings_count > 50000 
ORDER BY ratings_average DESC, ratings_count DESC
LIMIT 10;
-------
SELECT id, name, ratings_average, ratings_count, ratings_average * ratings_count AS overall_score
FROM wines
ORDER BY overall_score DESC, ratings_average DESC, ratings_count DESC
LIMIT 10;

--Which country should get marketing?

-- SELECT w.id, w.name, ratings_average, ratings_count, w.region_id, r.name as region_name, country_code, c.name, c.users_count, c.wines_count
-- FROM wines as w
-- INNER JOIN regions as r
-- ON w.region_id = r.id
-- INNER JOIN countries as c 
-- ON r.country_code = c.code
-- WHERE ratings_count > 50000 
-- ORDER BY c.users_count DESC, c.wines_count DESC;

-- SELECT w.id, w.name, AVG(ratings_average), r.name as region_name, country_code, SUM(c.users_count), c.wines_count, COUNT(country_code)
-- FROM wines as w
-- INNER JOIN regions as r
-- ON w.region_id = r.id
-- INNER JOIN countries as c 
-- ON r.country_code = c.code
-- WHERE ratings_count > 50000 
-- GROUP BY country_code
-- ORDER BY COUNT(country_code) DESC;

SELECT name, users_count, wines_count, users_count / wines_count AS user_wine_ratio
FROM countries
ORDER BY user_wine_ratio
LIMIT 3;

-- Best winery to give a price?

SELECT winery_id, w2.name as winery_name, ROUND(AVG(ratings_average),2) AS avg_ratings, SUM(ratings_count) AS total_ratings_count, COUNT(w1.name) AS wine_count, SUM(ratings_count) / COUNT(w1.name) AS ratings_count_wine_ratio
FROM wines AS w1
INNER JOIN wineries AS w2
ON w1.winery_id = w2.id
GROUP BY w2.name
HAVING COUNT(w1.name) > 1
ORDER BY ratings_count_wine_ratio DESC, avg_ratings DESC
LIMIT 5;

-- 5 keyword wines?

SELECT keyword_id, k.name as keyword_name, keyword_type, group_name, count, wine_id, w.name as wine_name, COUNT(wine_id)
FROM keywords_wine as kw
INNER JOIN keywords as k
ON kw.keyword_id = k.id
INNER JOIN wines as w
ON kw.wine_id = w.id
WHERE (k.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus'))
    AND (keyword_type = 'primary') AND (count > 10)
GROUP BY wine_id
HAVING COUNT(wine_id) = 5
ORDER BY wine_id;

-- Flavour of each selected primary keyword?

SELECT keyword_id, k.name as keyword_name, keyword_type, group_name
FROM keywords_wine as kw
INNER JOIN keywords as k
ON kw.keyword_id = k.id
WHERE (k.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus'))
    AND (keyword_type = 'primary')
GROUP BY k.name;

-- Top 3 most common `grape` all over the world?

SELECT grape_id, name AS grape_name, wines_count 
FROM most_used_grapes_per_country as m
INNER JOIN grapes AS g
ON m.grape_id = g.id
GROUP BY grape_id
ORDER BY wines_count DESC
LIMIT 3;

-- Average wine rating for each country?

SELECT c.name, c.users_count, c.wines_count, ROUND(AVG(ratings_average), 3) as avg_wine_rating
FROM wines as w
INNER JOIN regions as r
ON w.region_id = r.id
INNER JOIN countries as c 
ON r.country_code = c.code
GROUP BY c.name
ORDER BY avg_wine_rating DESC;

-- Average vintage rating for each country?

SELECT c.name, c.users_count, c.wines_count, ROUND(AVG(v.ratings_average), 3) as avg_vintage_rating
FROM vintages AS v
INNER JOIN wines as w
ON v.wine_id = w.id
INNER JOIN regions as r
ON w.region_id = r.id
INNER JOIN countries as c 
ON r.country_code = c.code
GROUP BY c.name
ORDER BY avg_vintage_rating DESC;

-- Top 5 recommendations to the VIP customer who likes Cabernet Sauvignon?

-- SELECT keyword_id, k.name as keyword_name, keyword_type, group_name, kw.count, wine_id, w.name as wine_name, AVG(count)
-- FROM keywords_wine as kw
-- INNER JOIN keywords as k
-- ON kw.keyword_id = k.id
-- INNER JOIN wines as w
-- ON kw.wine_id = w.id
-- WHERE (w.name LIKE '%Cabernet Sauvignon%') AND (count>=10) AND (keyword_type = 'primary')
-- GROUP BY wine_id
-- ORDER BY AVG(count) DESC, wine_id, count DESC;

SELECT id, name, ROUND(AVG(acidity),2), ROUND(AVG(intensity),2), 
    ROUND(AVG(sweetness),2), ROUND(AVG(tannin),2), 
    ROUND(AVG(user_structure_count),2), ROUND(AVG(ratings_average),2), 
    ROUND(AVG(ratings_count),2) 
FROM wines
WHERE name LIKE '%Cabernet Sauvignon%';

SELECT id, name, acidity, intensity, sweetness, tannin, user_structure_count, ratings_average, ratings_count
FROM wines
WHERE name NOT LIKE '%Cabernet Sauvignon%' AND
    (acidity BETWEEN 3.05 AND 3.55) AND
    (intensity BETWEEN 4.35 AND 4.85) AND
    (sweetness BETWEEN 1.45 AND 1.95) AND
    (tannin BETWEEN 3.15 AND 3.65)
ORDER BY user_structure_count DESC
LIMIT 5;

-- SELECT *
-- FROM toplists;

-- SELECT distinct w.name, w.id AS wine_id, w.ratings_average as wine_ratings_avg, v.ratings_average as vint_rat_avg, w.ratings_count, w.user_structure_count, v.price_euros
-- FROM wines AS w
-- INNER JOIN vintages AS v
-- ON w.id = v.wine_id
-- GROUP BY w.name
-- ORDER BY w.name, wine_ratings_avg;

-- SELECT vintage_id, w.id AS wine_id, w.name, w.ratings_average, w.ratings_count, w.user_structure_count, v.name AS vintage_name, v.wine_id, v.ratings_average AS vintages_ratings_avg, v.ratings_count AS vintages_ratings_cnt, price_euros, vtr.top_list_id, t.name AS toplist_name, country_code, rank, previous_rank
-- FROM vintage_toplists_rankings AS vtr
-- INNER JOIN toplists AS t
-- ON vtr.top_list_id = t.id
-- INNER JOIN vintages AS v
-- ON v.id = vtr.vintage_id
-- INNER JOIN wines AS w
-- ON v.wine_id = w.id
-- ORDER BY w.ratings_average DESC, wine_id, w.ratings_count DESC, toplist_name DESC, rank DESC;

