-- Завдання 1.Відобразити таблицю order_details та поле customer_id
-- з таблиці orders за допомогою вкладеного запиту в SELECT

SELECT
    od.*,
    (SELECT o.customer_id
     FROM orders o
     WHERE o.id = od.order_id) AS customer_id
FROM order_details od;


-- Завдання 2. Відфільтрувати order_details так, щоб відповідний запис
-- з orders мав shipper_id = 3 - Вкладений запит у WHERE

SELECT od.*
FROM order_details od
WHERE od.order_id IN (
    SELECT o.id
    FROM orders o
    WHERE o.shipper_id = 3
);


-- Завдання 3. Вкладений запит у FROM: рядки з quantity > 10,
-- середнє значення quantity, групування за order_id

SELECT
    order_id,
    AVG(quantity) AS avg_quantity
FROM (
    SELECT *
    FROM order_details
    WHERE quantity > 10
) AS temp
GROUP BY order_id;


-- Завдання 4. Те саме через оператор WITH

WITH temp AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT
    order_id,
    AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;


-- Завдання 5. Функція ділення двох FLOAT параметрів

DROP FUNCTION IF EXISTS DivideNumbers;

DELIMITER //

CREATE FUNCTION DivideNumbers(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    RETURN a / b;
END //

DELIMITER ;

SELECT
    id,
    order_id,
    quantity,
    DivideNumbers(quantity, 3) AS quantity_divided
FROM order_details;