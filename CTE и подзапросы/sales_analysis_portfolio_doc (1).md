
# SQL-проект для портфолио: Анализ продаж онлайн-магазина

## 📅 Цель проекта
Провести анализ базы данных интернет-магазина с использованием SQL, CTE и подзапросов, чтобы продемонстрировать навыки аналитики, сегментации клиентов и выявления бизнес-инсайтов.

## 📃 Структура базы данных

**Таблица `customers`** — информация о клиентах:
- customer_id
- first_name
- last_name
- email
- join_date
- country

**Таблица `products`** — информация о товарах:
- product_id
- product_name
- category
- price
- stock

**Таблица `orders`** — информация о заказах:
- order_id
- customer_id (FK)
- order_date
- total_amount

**Таблица `order_items`** — позиции в заказе:
- order_item_id
- order_id (FK)
- product_id (FK)
- quantity
- unit_price

## 🔹 SQL-анализ с использованием CTE и подзапросов

### 1. Общая выручка и средний чек за май 2025:
```sql
WITH monthly_orders AS (
    SELECT * FROM orders
    WHERE order_date BETWEEN '2025-05-01' AND '2025-05-31'
)
SELECT COUNT(*) AS total_orders,
       SUM(total_amount) AS total_revenue,
       AVG(total_amount) AS avg_order_value
FROM monthly_orders;
```

### 2. Топ-5 клиентов по тратам:
```sql
WITH customer_spending AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS full_name, cs.total_spent
FROM customer_spending cs
JOIN customers c ON cs.customer_id = c.customer_id
ORDER BY cs.total_spent DESC
LIMIT 5;
```

### 3. Топ-10 продаваемых товаров:
```sql
WITH product_sales AS (
    SELECT product_id, SUM(quantity) AS total_sold
    FROM order_items
    GROUP BY product_id
)
SELECT p.product_name, ps.total_sold
FROM product_sales ps
JOIN products p ON ps.product_id = p.product_id
ORDER BY ps.total_sold DESC
LIMIT 10;
```

### 4. Непроданные товары:
```sql
SELECT product_name
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id FROM order_items
);
```

### 5. Месячная динамика заказов и выручки:
```sql
WITH monthly_stats AS (
    SELECT DATE_TRUNC('month', order_date) AS month,
           COUNT(*) AS order_count,
           SUM(total_amount) AS revenue
    FROM orders
    GROUP BY month
)
SELECT * FROM monthly_stats ORDER BY month;
```

### 6. Средняя цена по категориям товаров:
```sql
SELECT category, ROUND(AVG(price), 2) AS avg_price
FROM products
GROUP BY category;
```

### 7. Повторные клиенты:
```sql
WITH repeat_customers AS (
    SELECT customer_id, COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
)
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS full_name, rc.order_count
FROM repeat_customers rc
JOIN customers c ON rc.customer_id = c.customer_id
ORDER BY rc.order_count DESC;
```

## 🔄 Возможные улучшения
- Построение графиков (Power BI, Excel)
- Сегментация клиентов по RFM
- Прогнозирование продаж (анализ временных рядов)
- Анализ корзины покупателя (частые комбинации)

## 📆 Вывод
Этот SQL-проект демонстрирует ключевые аналитические навыки: использование CTE, подзапросов, агрегатных функций и соединений таблиц для извлечения бизнес-ценной информации из данных продаж интернет-магазина.
