                             --- Task 2 Простые выборки

--- "имя контакта" и "город" (contact_name, country) из таблицы customers (только эти две колонки)
SELECT contact_name, country FROM customers;

--- идентификатор заказа и разницу между датами формирования (order_date) заказа и его отгрузкой (shipped_date) из таблицы orders
SELECT order_id, shipped_date - order_date FROM orders;

--- все города без повторов, в которых зарегестрированы заказчики (customers)
SELECT DISTINCT city FROM customers;

--- количество заказов (таблица orders)
SELECT COUNT(*) FROM orders;

--- количество стран, в которые откружался товар (таблица orders, колонка ship_country)
SELECT COUNT(DISTINCT ship_country) FROM orders;

--- Task 3 Фильтрация и сортировка

--- заказы, доставленные в страны France, Germany, Spain (таблица orders, колонка ship_country)
SELECT * FROM orders
WHERE ship_country IN ('France', 'Germany', 'Spain');

--- уникальные города и страны, куда отправлялись заказы, отсортировать
--- по странам и городам (таблица orders, колонки ship_country, ship_city)
SELECT DISTINCT(ship_country, ship_city) FROM orders;

--- сколько дней в среднем уходит на доставку товара в Германию
--- (таблица orders, колонки order_date, shipped_date, ship_country)
SELECT AVG(shipped_date - order_date) FROM orders
WHERE ship_country = 'Germany';

--- минимальную и максимальную цену среди продуктов, не снятых с продажи
--- (таблица products, колонки unit_price, discontinued не равно 1)
SELECT MIN(unit_price), MAX(unit_price) FROM products
WHERE discontinued = 0;

--- минимальную и максимальную цену среди продуктов, не снятых с продажи и которых
--- имеется не меньше 20 (таблица products, колонки unit_price, units_in_stock, discontinued не равно 1)
SELECT MIN(unit_price), MAX(unit_price) FROM products
WHERE units_in_stock >= 20 AND discontinued = 0;

--- Task 4 Фильтрация по шаблону и группировка

--- заказы, отправленные в города, заканчивающиеся на 'burg'.
SELECT * FROM orders
WHERE ship_city LIKE '%burg';

--- Вывести без повторений две колонки (город, страна) для заказов, отправленных в города,
--- заканчивающиеся на 'burg' (см. таблица orders, колонки ship_city, ship_country)
SELECT DISTINCT ship_city, ship_country FROM orders
WHERE ship_city LIKE '%burg';

--- из таблицы orders идентификатор заказа, идентификатор заказчика, вес и страну отгузки.
--- Заказ откружен в страны, начинающиеся на 'P'. Результат отсортирован по весу (по убыванию).
--- Вывести первые 10 записей.
SELECT order_id, customer_id, freight, ship_country FROM orders
WHERE ship_country LIKE 'P%'
ORDER BY freight DESC
LIMIT 10;

--- фамилию и телефон сотрудников, у которых в данных отсутствует регион (см таблицу employees)
SELECT last_name, home_phone FROM employees
WHERE region IS NULL;

--- количество поставщиков (suppliers) в каждой из стран. Результат отсортировать
--- по убыванию количества поставщиков в стране
SELECT country, COUNT(supplier_id) as count FROM suppliers
GROUP BY country
ORDER BY count DESC;

--- суммарный вес заказов (в которых известен регион) по странам, но вывести только те
--- результаты, где суммарный вес на страну больше 2750. Отсортировать по убыванию
--- суммарного веса (см таблицу orders, колонки ship_region, ship_country, freight)
SELECT ship_country, SUM(freight) as sum FROM orders
WHERE ship_region is NOT NULL
GROUP BY ship_country
HAVING SUM(freight) > 2750
ORDER BY sum DESC;

--- страны, в которых зарегистированы и заказчики (customers) и поставщики (suppliers) и работники (employees).
SELECT country FROM customers
INTERSECT
SELECT country FROM suppliers
INTERSECT
SELECT country FROM employees;

--- страны, в которых зарегистированы и заказчики (customers) и поставщики (suppliers),
--- но не зарегистрированы работники (employees)
SELECT country FROM customers
INTERSECT
SELECT country FROM suppliers
EXCEPT
SELECT country FROM employees;