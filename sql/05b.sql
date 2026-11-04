/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

SELECT f.title
FROM film f
JOIN film_actor fa1 ON f.film_id = fa1.film_id
JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
JOIN film g ON fa2.film_id = g.film_id
WHERE g.title = 'AMERICAN CIRCUS'
GROUP BY f.title
HAVING count(*) >= 2
ORDER BY f.title;
