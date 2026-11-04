/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */

(SELECT f.title
 FROM film f
 JOIN film_actor fa ON f.film_id = fa.film_id
 WHERE fa.actor_id IN (
     SELECT fa2.actor_id
     FROM film_actor fa2
     JOIN film g ON fa2.film_id = g.film_id
     WHERE g.title = 'AMERICAN CIRCUS'))
INTERSECT
(SELECT f.title
 FROM film f
 JOIN film_actor fa ON f.film_id = fa.film_id
 WHERE fa.actor_id IN (
     SELECT fa2.actor_id
     FROM film_actor fa2
     JOIN film g ON fa2.film_id = g.film_id
     WHERE g.title = 'ACADEMY DINOSAUR'))
INTERSECT
(SELECT f.title
 FROM film f
 JOIN film_actor fa ON f.film_id = fa.film_id
 WHERE fa.actor_id IN (
     SELECT fa2.actor_id
     FROM film_actor fa2
     JOIN film g ON fa2.film_id = g.film_id
     WHERE g.title = 'AGENT TRUMAN'))
ORDER BY title;
