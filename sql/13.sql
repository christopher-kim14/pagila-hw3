/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

WITH revenue AS (
    SELECT f.film_id, f.title, COALESCE(sum(p.amount), 0) AS total
    FROM film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY f.film_id, f.title
),
ranked AS (
    SELECT a.actor_id,
           a.first_name, a.last_name,
           rev.film_id, rev.title, rev.total,
           rank() OVER (PARTITION BY a.actor_id ORDER BY rev.total DESC, rev.title) AS rank
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN revenue rev ON fa.film_id = rev.film_id
)
SELECT actor_id, first_name, last_name, film_id, title, rank, total AS revenue
FROM ranked
WHERE rank <= 3
ORDER BY actor_id, rank;
