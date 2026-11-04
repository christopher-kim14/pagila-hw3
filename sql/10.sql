/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */

WITH spending AS (
    SELECT customer_id, sum(amount) AS total_payment
    FROM payment
    GROUP BY customer_id
),
percentiles AS (
    SELECT c.customer_id,
           c.first_name || ' ' || c.last_name AS name,
           s.total_payment,
           ntile(100) OVER (ORDER BY s.total_payment) AS percentile
    FROM customer c
    JOIN spending s ON c.customer_id = s.customer_id
)
SELECT customer_id, name, total_payment, percentile
FROM percentiles
WHERE percentile >= 90
ORDER BY name;
