--Top 10 wines
SELECT id, name, ratings_average, ratings_count
FROM wines 
WHERE ratings_count > 50000 
ORDER BY ratings_average DESC, ratings_count DESC
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

SELECT *
FROM countries
ORDER BY users_count
LIMIT 3;

-- Best winery to give a price?

SELECT w1.id as wine_id, w1.name as wine_name, ratings_average, ratings_count, w2.name as winery_name
FROM wines AS w1
INNER JOIN wineries AS w2
ON w1.winery_id = w2.id
WHERE ratings_count > 50000 
ORDER BY ratings_average DESC, ratings_count DESC
LIMIT 5;

-- 5 keyword wines?

SELECT keyword_id, k.name as keyword_name, keyword_type, group_name, count, wine_id, COUNT(wine_id), w.name as wine_name
FROM keywords_wine as kw
INNER JOIN keywords as k
ON kw.keyword_id = k.id
INNER JOIN wines as w
ON kw.wine_id = w.id
WHERE (k.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus'))
    AND (keyword_type = 'primary') AND (count > 10)
GROUP BY wine_id
ORDER BY COUNT(wine_id) DESC, wine_id;

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

