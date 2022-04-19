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

