--Ej1
select CONCAT(c.first_name, ' ', c.last_name) as nombre,a.address as direccion, ci.city as ciudad
from customer c
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
where co.country = 'Argentina'
order by nombre desc;

--Ej2
select f.title, l.name as languaje, f.rating,
case
when f.rating = 'G' then 'All ages admitted'
when f.rating = 'PG' then 'Some material may not be suitable for children'
when f.rating = 'PG-13' then 'Some material may be inappropriate for children under 13'
when f.rating = 'R' then 'Under 17 requires accompanying parent or adult guardian'
when f.rating = 'NC-17' then 'No one 17 and under admitted'
end as 'Rating'
from film as f
inner join language l on f.language_id = l.language_id;

--Ej3
select a.first_name,  a.last_name , f.title AS film, f.release_year 
from film f
inner join film_actor fa on f.film_id = fa.film_id
inner join actor a on fa.actor_id = a.actor_id
where a.first_name = upper('CHRIS')
and a.last_name = upper('BRIDGES');

--Ej4
select f.title, r.rental_date, c.first_name,
case when r.return_date is not null then 'Yes'
else 'No'
end as 'Returned'
from rental r
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
inner join customer c on r.customer_id = c.customer_id
where MONTH(r.rental_date) = 5 or MONTH(r.rental_date) = 6;

--Ej5

-- Función CAST: La función CAST se usa para convertir un valor de un tipo de datos a otro tipo específico. 
select title, cast(rental_duration / 60.0 as DECIMAL(3,2)) as duration
from film;

-- Función CONVERT: Por otro lado, la función CONVERT también se usa para la conversión de tipos de datos, pero ofrece una funcionalidad más. 
-- Además de cambiar tipos, CONVERT permite la conversión de conjuntos de caracteres, por lo que puedes ajustar el juego de caracteres de los datos. 
select CONVERT(LAST_UPDATE, DATE)
from film;

-- Diferencias clave:
-- La principal diferencia radica en la capacidad de CONVERT para manejar la conversión de conjuntos de caracteres. 
-- Podés cambiar la representación de los caracteres en una columna usando esta función. Por otro lado, CAST se usa exclusivamente para cambiar el tipo de datos de un valor.

--Ej6
-- Estas funciones, como NVL, ISNULL, IFNULL y COALESCE, permiten devolver un valor alternativo cuando una consulta da como resultado null.

-- Diferencias entre ellas:
-- Cada función se usa en diferentes sistemas de administración de bases de datos. En mysql estan disponibles IFNULL y COALESCE, 
-- NVL e ISNULL no están disponibles.
-- Ejemplos de uso:
-- IFNULL:
-- Cambia todos los original language por el numero 1 
select film_id, ifnull(original_language_id, 1)
from film;

-- COALESCE:
-- lo mismo que antes pero usando la función coalesce:
select film_id, coalesce(original_language_id, 1)
from film;
