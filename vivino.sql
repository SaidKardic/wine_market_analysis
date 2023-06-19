--Top 10 wines
SELECT id, name, ratings_average, ratings_count
FROM wines 
WHERE ratings_count > 50000 
ORDER BY ratings_average DESC, ratings_count DESC
LIMIT 10;

--Which country should get marketing?

SELECT name, users_count, wines_count, ROUND((users_count * 1.0) / (wines_count * 1.0), 2) AS user_wine_ratio
FROM countries
ORDER BY user_wine_ratio
LIMIT 5;

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

SELECT id, name, ROUND(AVG(acidity),2), ROUND(AVG(intensity),2), 
    ROUND(AVG(sweetness),2), ROUND(AVG(tannin),2), 
    ROUND(AVG(user_structure_count),2), ROUND(AVG(ratings_average),2), 
    ROUND(AVG(ratings_count),2) 
FROM wines
WHERE name LIKE '%Cabernet Sauvignon%';

SELECT id, name, acidity, intensity, sweetness, tannin, user_structure_count, ratings_average, ratings_count
FROM wines
WHERE name NOT LIKE '%Cabernet Sauvignon%' AND
    (acidity BETWEEN 3.06 AND 3.57) AND
    (intensity BETWEEN 4.34 AND 4.84) AND
    (sweetness BETWEEN 1.45 AND 1.95) AND
    (tannin BETWEEN 3.14 AND 3.64)
ORDER BY user_structure_count DESC
LIMIT 5;