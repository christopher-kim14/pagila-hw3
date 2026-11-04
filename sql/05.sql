/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN film_actor fa2 ON fa.actor_id = fa2.actor_id
JOIN film g ON fa2.film_id = g.film_id
WHERE g.title = 'AMERICAN CIRCUS'
ORDER BY f.title;
