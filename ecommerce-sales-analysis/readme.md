## E-commerce Sales Analysis (SQL Project)

## Описание проекта

Этот проект демонстрирует аналитический подход к данным интернет-магазина с помощью SQL. Используются данные о клиентах, товарах и заказах для анализа поведения пользователей, продаж по категориям и жизненной ценности клиента (CLV).

## Структура данных

Файл ecommerce_sales_project.xlsx содержит три таблицы:

### `customers`

| Поле              | Тип     | Описание                  |
|-------------------|---------|----------------------------|
| customer_id       | INT     | Уникальный ID клиента     |
| gender            | TEXT    | Пол                       |
| age               | INT     | Возраст                   |
| city              | TEXT    | Город                     |
| registration_date | DATE    | Дата регистрации          |

products

Поле Тип Описание

product_id INT Уникальный ID товара
category TEXT Категория
price NUMERIC Цена

orders

Поле Тип Описание

order_id INT Уникальный ID заказа
customer_id INT ID клиента
product_id INT ID товара
order_date DATE Дата заказа
