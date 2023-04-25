--Ej1
SELECT a.first_name, a.last_name
FROM actor a
WHERE EXISTS (
  SELECT *
  FROM actor b 
  WHERE a.last_name=b.last_name
    AND a.actor_id <> b.actor_id
)
order by a.last_name;


--Ej2
select a.first_name, a.last_name
from actor as a 
where not exists (
  select * 
  from film_actor
  where a.actor_id=film_actor.actor_id
);

--Ej3
select c.first_name, c.last_name
from customer as c
where  (
  select count(*)
  from rental
  where c.customer_id=rental.customer_id
)=1;

--Ej4
select c.first_name, c.last_name
from customer as c
where(
  select count(*)
  from rental
  where c.customer_id=rental.customer_id
)>1;

--Ej5
select a.first_name, a.last_name
from actor as  a
where a.actor_id in(
  select fa.actor_id
  from film_actor as fa
  where fa.film_id in(
    select f.film_id
    from film as f
    where f.title in ('BETRAYED REAR', 'CATCH AMISTAD')
  )
);

--Ej6
select a.first_name, a.last_name 
from actor as a
where exists (
  select * from film f join film_actor fa on f.film_id = fa.film_id
  where f.film_id = fa.film_id and a.actor_id = fa.actor_id and 
  (f.title = 'BETRAYED REAR' and  f.title != 'CATCH AMISTAD'));

--Ej7
select a.first_name, a.last_name 
from actor a
where EXISTS (
  select * from film f join film_actor fa ON f.film_id = fa.film_id 
  where fa.actor_id = a.actor_id and f.title = 'BETRAYED REAR')
  and exists (
    select * from film f join film_actor fa ON f.film_id = fa.film_id 
    where fa.actor_id = a.actor_id and f.title = 'CATCH AMISTAD');

--Ej8
select a.first_name, a.last_name
from actor  a
where not exists (
  select *
  from film as f 
  join film_actor fa ON f.film_id = fa.film_id
  where fa.actor_id = a.actor_id 
  and (f.title = 'BETRAYED REAR' OR f.title = 'CATCH AMISTAD')
);
