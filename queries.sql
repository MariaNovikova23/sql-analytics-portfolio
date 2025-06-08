-- 1. Общая сумма заказов (total revenue)
SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- 2. Количество заказов по дням
SELECT order_date, COUNT(*) AS order_count
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- 3. Самый продаваемый товар
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;

-- 4. Средний чек по заказу
SELECT AVG(total_amount) AS avg_order_value
FROM orders;

-- 5. Выручка по категориям
SELECT c.category_name, SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY category_revenue DESC;