/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH bacall AS (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id IN (
        SELECT film_id
        FROM film_actor
        WHERE actor_id = (SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL')
    )
)
SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id IN (SELECT actor_id FROM bacall)
)
AND a.actor_id NOT IN (SELECT actor_id FROM bacall)
ORDER BY "Actor Name";
