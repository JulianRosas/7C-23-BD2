------------------------------------------------------------Guia 13-------------------------------------------------------------------------------------------------------------------------------
--Ej1
insert into customer (store_id, first_name, last_name, email, address_id, active, cre ate_date, last_update) VALUES (1, 'Julian','Rosas', 'julymaxrosas@gmail.com',(select max(a.address_id)
from address as a
inner join city as ci on a.city_id = ci.city_id
inner join country co on ci.country_id = co.country_id
where co.country = 'United States'), 1, CURRENT_TIME(), CURRENT_TIMESTAMP());

--Ej2
insert into rental (rental_date, inventory_id, customer_id, return_date, staff_id) VALUES (CURRENT_DATE(), (SELECT i.inventory_id
from inventory as i
join film as f on i.film_id = f.film_id
where f.title = 'BETRAYED REAR'
limit 1), 1, CURRENT_DATE(), (select min(staff_id)
from staff
where store_id = 2));

--Ej3
update film
set release_year = case rating
when 'G' then '2001'
when 'NC-17' then '2007'
else release_year end;


--Ej4
select r.rental_id, r.return_date
from film f
inner join inventory i using(film_id)
inner join rental r using(inventory_id)
where r.return_date is null
order by r.rental_date desc
limit 10;
UPDATE rental
SET return_date = CURRENT_TIMESTAMP
WHERE rental_id = 5078;

--Ej5
delete
from film
where film_id = 7;
/* No se puede eliminar ya que la pelicula  tiene claves foraneas que dependen de ella */

--Ej6
insert into rental (rental_date, inventory_id, customer_id, return_date, staff_id) values (CURRENT_DATE(), (select i.inventory_id
from inventory  i
where not exists(select *
from rental r
where r.inventory_id = i.inventory_id
and r.return_date < CURRENT_DATE())
limit 1), 1, CURRENT_DATE(), 1);
insert into payment (customer_id, staff_id, rental_id, amount, payment_date) values (1, 1, (SELECT LAST_INSERT_ID()), 10.2, CURRENT_DATE)
