/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

WITH rental_counts AS (
    SELECT f.film_id, f.title, count(r.rental_id) AS count
    FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY f.film_id, f.title
),
ranked AS (
    SELECT c.category_id, c.name, rc.title, rc.count,
           rank() OVER (PARTITION BY c.category_id ORDER BY rc.count DESC, rc.title DESC) AS rank
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN rental_counts rc ON fc.film_id = rc.film_id
)
SELECT name, title, count AS "total rentals"
FROM ranked
WHERE rank <= 5
ORDER BY name, count DESC, title;
