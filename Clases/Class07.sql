--Ej1
select title, length, rating
from film 
where length <= ALL (SELECT length  FROM film );

--Ej2
select title, length
from film f
where length <= ALL  (select length from film )
and not exists(select * from film as f2 where f2.film_id <> f.film_id and f2.length <= f.length);

--Ej3
select concat(c.first_name, " " ,c.last_name) as "Nombre completo", a.address, min(p.amount)  as "Paga minima"
from customer c
join address a on c.address_id = a.address_id
join payment  p on c.customer_id = p.customer_id
where p.amount = all (
  select MIN(amount)
  from payment
  where customer_id = c.customer_id)
group by c.first_name, c.last_name, a.address;



--Ej4 
select concat(c.first_name," ",c.last_name) as "Nombre completo",  a.address, min(p.amount) as "Paga minima", max(p.amount) as "Paga maxima"
from customer c
join address a on c.address_id = a.address_id
join payment p on c.customer_id = p.customer_id
group by c.first_name, c.last_name, a.address;
