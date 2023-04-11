use sakila;
-- Ej1
SELECT title, special_features from film where rating="PG-13";

-- Ej2
select title, length from film;

--Ej3
select title, rental_rate, replacement_cost from film where replacement_cost BETWEEN 20 and 24;

--Ej4
select f.title, c.name, f.rating, f.special_features 
from film f  
inner join category c  on  category_id
where special_features ="Behind the scenes";


--Ej5
select a.first_name, a.last_name, f.title
from actor a
inner join film f on film_id
where f.title="ZOOLANDER FICTION";

--Ej6
select a.address, c.city, co.country, s.store_id
from store s
inner join address a on a.address_id = s.store_id
inner join city c on c.city_id = a.address_id
inner join country co on co.country_id = c.city_id
where s.store_id = 1;

--Ej7
select film1.title, film2.title
from film as film1,
     film AS film2
where film1.rating = film2.rating
  and film1.film_id != film2.film_id;

--Ej8
select f.title, st.first_name, st.last_name, s.store_id
from store s
inner join film f on f.film_id = s.store_id
inner join staff st on st.staff_id = f.film_id
where s.store_id = 2;