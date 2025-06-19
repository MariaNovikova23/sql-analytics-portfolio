- 📈 Суммарная выручка по всем заказам
SELECT 
    SUM("total_amount") AS "total_revenue"
FROM 
    "orders";

-- 📅 Количество заказов и выручка по месяцам
SELECT 
    DATE_TRUNC('month', "order_date") AS "month",
    COUNT("order_id") AS "total_orders",
    SUM("total_amount") AS "revenue"
FROM 
    "orders"
GROUP BY 
    "month"
ORDER BY 
    "month";

-- 💵 Средний чек по заказу (Average Order Value)
SELECT 
    AVG("total_amount") AS "average_order_value"
FROM 
    "orders";

-- 🔁 Повторные и однократные клиенты
SELECT 
    "repeat_type",
    COUNT(DISTINCT "customer_id") AS "num_customers"
FROM (
    SELECT 
        "customer_id",
        CASE 
            WHEN COUNT("order_id") = 1 THEN 'Однократный'
            ELSE 'Повторный'
        END AS "repeat_type"
    FROM 
        "orders"
    GROUP BY 
        "customer_id"
) AS "sub"
GROUP BY 
    "repeat_type";

-- 🛒 ТОП-5 товаров по продажам
SELECT 
    "p"."product_id",
    "p"."category",
    SUM("o"."quantity") AS "total_units_sold",
    SUM("o"."total_amount") AS "total_revenue"
FROM 
    "orders" AS "o"
JOIN 
    "products" AS "p" ON "o"."product_id" = "p"."product_id"
GROUP BY 
    "p"."product_id", 
    "p"."category"
ORDER BY 
    "total_units_sold" DESC
LIMIT 5;

-- 💰 Customer Lifetime Value (CLV): ТОП-10 клиентов
SELECT 
    "c"."customer_id",
    "c"."city",
    ROUND(SUM("o"."total_amount"), 2) AS "clv"
FROM 
    "customers" AS "c"
JOIN 
    "orders" AS "o" ON "c"."customer_id" = "o"."customer_id"
GROUP BY 
    "c"."customer_id", 
    "c"."city"
ORDER BY 
    "clv" DESC
LIMIT 10;
