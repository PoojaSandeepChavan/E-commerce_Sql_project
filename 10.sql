USE ECOMMERCE_DB;

SELECT p.product_name, SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

SELECT c.customer_name, SUM(od.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


SELECT AVG(order_total) AS average_order_value
FROM (
    SELECT o.order_id, SUM(od.quantity * p.price) AS order_total
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.order_id
) AS order_totals;

SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

SELECT p.product_name, d.discount_amount, COUNT(od.order_id) AS total_orders_with_discount
FROM discounts d
JOIN products p ON d.product_id = p.product_id
LEFT JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name, d.discount_amount
ORDER BY total_orders_with_discount DESC;

SELECT product_name, stock_qty
FROM products
WHERE stock_qty < 100
ORDER BY stock_qty ASC;

SELECT p.product_name, AVG(r.rating) AS average_rating, COUNT(r.review_id) AS total_reviews
FROM reviews r
JOIN products p ON r.product_id = p.product_id
GROUP BY p.product_name
ORDER BY average_rating DESC;


SELECT AVG(DATEDIFF(s.deliverydate, s.shipdate)) AS average_delivery_time
FROM shipping s;


SELECT MONTH(order_date) AS order_month, COUNT(order_id) AS total_orders
FROM orders
GROUP BY MONTH(order_date)
ORDER BY total_orders DESC;

