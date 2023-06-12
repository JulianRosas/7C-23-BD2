-----------------------------------------------------------------------------------------------------------------------------------------------
--Ej4
select f.title 
from film f 
where not exists(select i.film_id from inventory i where f.film_id=i.film_id);


--Ej5
select f.title, i2.inventory_id
from film f
join inventory i2 on f.film_id=i2.film_id
where exists(select i2.film_id from inventory i where f.film_id=i.film_id
and not exists(select r.inventory_id from rental r where r.inventory_id=i.inventory_id));

--Ej6
select c.first_name,c.last_name, s.store_id, f.title
from customer c 
join store s on s.store_id=c.store_id
join inventory i on s.store_id=i.store_id
join film f on i.film_id=f.film_id
where exists(select r.customer_id from rental r where r.customer_id=c.customer_id and r.return_date is not null)
order by s.store_id, c.last_name;

--Ej7
select s.store_id, concat(ci.city," ", c.country) as lugar, sum(p.amount) as Ventas, concat(st.first_name," ",st.last_name) as ManagerInfo
from store s
join address a on s.address_id=a.address_id
join city ci on a.city_id=ci.city_id
join country c on ci.country_id=c.country_id
join staff st on s.store_id=st.store_id
join payment p on st.staff_id=p.staff_id
group by s.store_id, ManagerInfo;

--Ej8
select a.first_name, a.last_name, count(fa.film_id) as contador
from actor a 
join film_actor fa on a.actor_id=fa.actor_id
join film f on fa.film_id=f.film_id
group by a.first_name,a.last_name
order by contador desc;