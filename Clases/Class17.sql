--------------------------------------------------------------------------GUIA 17--------------------------------------------------------------------------------

--Ej1
select a.address, ci.city, co.country, a.postal_code
from address a 
join city ci on a.city_id=ci.city_id
join country co on ci.country_id=co.country_id
where a.postal_code in (99865,34021,45750,79047)
order by co.country asc
;
--16ms en ejecutarla
--8ms con el index creado

select a.address, ci.city, co.country, a.postal_code
from address a 
join city ci on a.city_id=ci.city_id
join country co on ci.country_id=co.country_id
where a.postal_code not in (99865,34021,45750,79047)
order by co.country asc
;
--11ms en ejecutarla
--10ms con el index creado

create index postalcode on address(postal_code);

--Al crear el index la base de datos puede usar estos para acortar el tiempo de busqueda, ya q no tiene q ir buscando los valores uno por uno en la base de datos


--Ej2
select first_name 
from actor;
--53ms 
--21ms con el index creado

select last_name from actor;
--17ms 

--Podemos ver que claramente se tarda menos buscando last_name, esto pasa ya que hay un index existente con last_name
show index from actor;
--Si quisieramos que el tiempo de first_name disminuyera simplemente creamos un nuevo index
create index firstname on actor(first_name);

--Ej3 
select description from film;

select description 
from film 
where description like '%Panorama%';
--19ms

SELECT description									
FROM film
WHERE MATCH(description) AGAINST('%Panorama%');
--Nos tira error, esto es pq hay q crear un index "FULLTEXT"
--15ms una vez creado el index

CREATE FULLTEXT INDEX film_description_idx ON film(description);

--Podemos ver q utilizanso "FULLTEXT" la query se ejecuta un poco mas rapido