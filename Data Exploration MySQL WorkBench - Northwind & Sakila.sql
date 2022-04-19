-- Ejercicio 1
Select first_name As Nombre, last_name As Apellido 
From actor
LIMIT 5;

-- Ejercicio 2
-- Con tres condiciones diferentes, devuelve lo mismo
Select first_name As Nombre, last_name As Apellido, email As Correo
From customer
Where active <> True
;
Select first_name As Nombre, last_name As Apellido, email As Correo
From customer
Where active = False
;
Select first_name As Nombre, last_name As Apellido, email As Correo
From customer
Where active = 0
;

-- Ejercicio 3
Select title as Titulo, description as Descripcion, release_year as "Año"
From film
Where rental_duration > 5
order by rental_duration DESC
;

-- Ejercicio 4
SELECT * 
From rental
WHERE DATE(rental_date) between '2005-05-01' and '2005-05-31'
;
SELECT * 
From rental
WHERE DATE(rental_date) >= '2005-05-01' and rental_date <='2005-05-31'
;

SELECT * 
From rental
WHERE MONTH(rental_date) = 5 AND YEAR(rental_date) = 2005
GROUP BY 1;

-- Ejercicio 5 
SELECT COUNT(Distinct rental_id) AS Cantidad
from rental;

-- Ejercicio 6
SELECT sum(amount) AS TOTAL
, count(distinct rental_id) AS CANTIDAD 
, sum(amount) / count(distinct rental_id) AS 'Importe Promedio'
FROM payment;
-- Con formato, cast() function
SELECT sum(amount) AS TOTAL
, count(distinct rental_id) AS CANTIDAD 
, CAST(sum(amount) / count(distinct rental_id) As Decimal(9,2)) AS 'Importe Promedio'
FROM payment;
-- Con formato, convert() function
SELECT sum(amount) AS TOTAL
, count(distinct rental_id) AS CANTIDAD 
, CONVERT(sum(amount) / count(distinct rental_id) , Decimal(9,2)) AS 'Importe Promedio'
FROM payment;


-- Ejercicio 7
SELECT customer_id, sum(amount), count(distinct rental_id) FROM payment
group by customer_id
order by sum(amount) desc 
limit 10;

-- Ejercicio 7 BIS
SELECT customer_id, sum(amount), count(distinct rental_id) FROM payment
group by customer_id
having sum(amount)>150
order by sum(amount) desc 
;

-- Ejercicio 8
Select month(rental_date) mes,
       monthname(rental_date) MesN, 
       SUM(amount) AS Monto, 
	   COUNT(distinct payment.rental_id) AS CantidadAlquileres
From payment
INNER JOIN rental
ON payment.rental_id = rental.rental_id
Where year(rental_date) = 2005
Group By month(rental_date),monthname(rental_date)
;

-- Ejercicio 9
SELECT inventory_id, count(rental_id)
from rental
group by inventory_id
order by count(rental_id) desc
Limit 5;

-- Ejercicio 10
Select address.address,
	   month(rental.rental_date),
       SUM(amount) AS Monto, 
	   COUNT(distinct payment.rental_id) AS CantidadAlquileres
From rental
INNER JOIN payment
ON  payment.rental_id = rental.rental_id
Inner Join inventory
ON  inventory.inventory_id = rental.inventory_id
INNER JOIN store
ON inventory.store_id = store.store_id
Inner JOIN address
ON address.address_id = store.address_id
Group By address.address, month(rental.rental_date)
;

-- Ejercicio 10
-- 7 Con JOIN
-- Ejercicio 7 con Join
Select customer.first_name, customer.last_name , SUM(amount) AS Monto, COUNT(distinct rental_id) AS CantidadAlquileres
From payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
Group By customer.first_name, customer.last_name
order by Monto DESC
Limit 10;

-- Ejercicio 7 bis con Join
Select customer.first_name, customer.last_name , SUM(amount) AS Monto, COUNT(distinct rental_id) AS CantidadAlquileres
From payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
Group By customer.first_name, customer.last_name
having monto > 150
order by Monto DESC;

-- Ejercicio 9 con Join
Select film.title, count(Distinct rental.rental_id) CantAlq
From rental
INNER join inventory
ON  inventory.inventory_id = rental.inventory_id
Inner Join film
ON film.film_id = inventory.film_id
Group By film.title
Order by CantAlq DESC
limit 5;


-- Ejercicio 11
Select store.store_id,
	   month(rental.rental_date),
       SUM(amount) AS Monto, 
	   COUNT(distinct payment.rental_id) AS CantidadAlquileres
From rental
INNER JOIN payment
ON  payment.rental_id = rental.rental_id
Inner Join inventory
ON  inventory.inventory_id = rental.inventory_id
INNER JOIN store
ON inventory.store_id = store.store_id
Group By store.store_id, month(rental.rental_date)
;


-- Ejercicio 12
-- Top 10
Select film.title, SUM(amount) as Total, count(Distinct rental.rental_id) CantAlq
From rental
INNER JOIN payment
ON  payment.rental_id = rental.rental_id
INNER join inventory
ON  inventory.inventory_id = rental.inventory_id
Inner Join film
ON film.film_id = inventory.film_id
Group By film.title
Order by total DESC
limit 10;
-- Bottom 10
Select film.title, SUM(amount) as Total, count(Distinct rental.rental_id) CantAlq
From rental
INNER JOIN payment
ON  payment.rental_id = rental.rental_id
INNER join inventory
ON  inventory.inventory_id = rental.inventory_id
Inner Join film
ON film.film_id = inventory.film_id
Group By film.title
Order by total asc
limit 10;


-- Ejercicio 13 
SELECT store_id, SUM(junio) junio, SUM(julio) julio
FROM (
Select store.store_id store_id,
	   month(rental.rental_date) mes,
       SUM(amount) AS Junio,
       0 AS Julio
From rental
INNER JOIN payment
ON  payment.rental_id = rental.rental_id
Inner Join inventory
ON  inventory.inventory_id = rental.inventory_id
INNER JOIN store
ON inventory.store_id = store.store_id
WHERE month(rental.rental_date) = 6
Group By store.store_id, month(rental.rental_date)
UNION 
Select store.store_id,
	   month(rental.rental_date),
       0 AS Junio,
       SUM(amount) AS Julio
From rental
INNER JOIN payment
ON  payment.rental_id = rental.rental_id
Inner Join inventory
ON  inventory.inventory_id = rental.inventory_id
INNER JOIN store
ON inventory.store_id = store.store_id
WHERE month(rental.rental_date) = 7
Group By store.store_id, month(rental.rental_date)
) AS variacion
GROUP BY store_id;


-- Ejercicio 1
-- Liste el detalle de las ordenes, ordenado por el Order Id
SELECT 	orders.id, 
		orders.order_date, 
        orders.ship_address, 
        order_details.product_id, 
        order_details.quantity, 
        order_details.unit_price
From orders
JOIN order_details
ON orders.Id = order_details.order_id
ORDER BY Orders.id;


-- Ejercicio 1 - Bonus Track
-- Agregue al ejercicio 1, la descripcion de los productos
SELECT 	orders.id, 
		orders.order_date, 
        orders.ship_address, 
        order_details.product_id,
        products.product_name,
        order_details.quantity, 
        order_details.unit_price
From orders
JOIN order_details
ON orders.Id = order_details.order_id
JOIN products
ON products.id = order_details.product_id
;

-- Ejercicio 2
-- Agregue al listado una columna que sea el Importe.
SELECT 	orders.id, 
		orders.order_date, 
        orders.ship_address, 
        order_details.product_id, 
        order_details.quantity, 
        order_details.unit_price,
		order_details.quantity * order_details.unit_price AS Importe
From orders
JOIN order_details
ON orders.Id = order_details.order_id
ORDER BY Orders.id;

-- Ejercicio 3
-- Filtre para el listado del punto 1, solo la orden 44
SELECT 	orders.id, 
		orders.order_date, 
        orders.ship_address, 
        order_details.product_id, 
        order_details.quantity, 
        order_details.unit_price
From orders
JOIN order_details
ON orders.Id = order_details.order_id
WHERE orders.Id = 44
ORDER BY Orders.id;

-- Ejercicio 4
-- Muestra todos los campos de las ordenes del employee “Sergienko”
SELECT orders.* 
From orders
JOIN employees
ON orders.employee_id = employees.id
WHERE employees.last_name = 'Sergienko';

-- Ejercicio 5
-- Muestra todos los campos de las ordenes que tienen status distinto a Closed
SELECT orders.* 
From orders
JOIN orders_status
ON orders.status_id = orders_status.id
WHERE orders_status.status_name <> 'Closed';

-- Ejercicio 6
-- Muestra todos los campos de las ordenes con el nombre y apellido de los empleados
SELECT orders.*,
       employees.first_name,
       employees.last_name
From orders
JOIN employees
ON orders.employee_id = employees.id;

-- Ejercicio 7
-- Muestre un listado con todos los clientes que hayan realizado compras cuyo “status order” sea “New”, y la ciudad de envio sea “New York”
SELECT customers.* 
From customers
JOIN orders
ON orders.customer_id = customers.id
JOIN orders_status
ON orders.status_id = orders_status.id
WHERE orders_status.status_name = 'New'
AND orders.ship_city = 'New York';

-- Idem, pero sin duplicados
SELECT DISTINCT customers.* 
From customers
JOIN orders
ON orders.customer_id = customers.id
JOIN orders_status
ON orders.status_id = orders_status.id
WHERE orders_status.status_name = 'New'
AND orders.ship_city = 'New York';

-- Ejercicio 8
-- Muestra todos los campos de las ordenes del empleado cuyo apellido  sea “Kotas” o que incluyan el producto id = “80”
SELECT orders.* 
From orders
JOIN employees
ON orders.employee_id = employees.id
JOIN order_details
ON orders.id = order_details.order_id
WHERE employees.last_name = 'Kotas'
or order_details.product_id = 80;

-- Ejercicio 9
-- Muestra todos los campos de las ordenes del empleado cuyo apellido  sea “Kotas” y que incluyan el producto id = “80”
SELECT orders.* 
From orders
JOIN employees
ON orders.employee_id = employees.id
JOIN order_details
ON orders.id = order_details.order_id
WHERE employees.last_name = 'Kotas'
and order_details.product_id = 80;

-- Ejercicio 10
-- Haga un listado con los cinco mejores clientes, segun sus importes de compras
Select 	customers.id,
		customers.first_name,
		customers.last_name,
		SUM(order_details.quantity * order_details.unit_price) AS importe
From orders
Join customers On customers.id = orders.customer_id
Join order_details on order_details.order_id = orders.id
GROUP BY customers.id, customers.first_name, customers.last_name
Order BY importe DESC
LImit 5;

-- Ejercicio 11
-- Haga un listado de ordenes, con los campos id, nombre y apellido del cliente,  order date, y pais de envio, con las 5 ordenes mas recientes
Select 	orders.id,
		customers.first_name,
		customers.last_name,
        orders.order_date,
        orders.ship_country_region
From orders
Join customers On customers.id = orders.customer_id
Order BY orders.order_date DESC
Limit 5;
