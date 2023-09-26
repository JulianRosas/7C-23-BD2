--Ej1
create function amount_of_copies(film_name VARCHAR(190), store_id INT) returns int deterministic
begin 
	declare cantidad INT;
	select
	    COUNT(i.inventory_id) into cantidad
	from film f
	    inner join inventory i using(film_id)
	    inner join store s using(store_id)
	where
	    f.title = film_name and s.store_id = store_id;
	RETURN (cantidad);
END;
drop function amount_of_copiest;

select f.title, f.film_id, s.store_id
from film f 
join inventory i on i.film_id = f.film_id
join store s on i.store_id = s.store_id
where s.store_id = 1;

select amount_of_copies('ANGELS LIFE',1);


--Ej2
create procedure ClientsPerCountry(IN p_pais varchar(50), out p_lista_clientes varchar(1000))
begin
    declare hecho INT DEFAULT 0;
    declare nombre VARCHAR(190);
    declare clientes_pais CURSOR FOR
        select CONCAT(c.first_name, ' ', c.last_name)
        from customer c
        inner join address a on c.address_id = a.address_id
        inner join city ci on a.city_id = ci.city_id
        inner join country co on ci.country_id = co.country_id
        where co.country = p_pais;

    declare continue handler for not found set hecho = 1;

    set p_lista_clientes = '';

    open clientes_pais;

    fetch clientes_pais into nombre;

    while NOT hecho DO
        IF p_lista_clientes = '' THEN
            SET p_lista_clientes = nombre;
        else
            SET p_lista_clientes = CONCAT(p_lista_clientes, ';', nombre);
        END IF;

        FETCH clientes_pais INTO nombre;
    END WHILE;

    CLOSE clientes_pais;
END;

drop function ClientsPerCountry;
CALL ClientsPerCountry('Italy', @lista_clientes);
SELECT @lista_clientes;


--Ej3
-- Función inventory_in_stock:
-- Esta es una función predeterminada en SQL que toma dos parámetros, el ID de la películ y el ID de la tienda 
-- y devuelve un valor boolean que te dice si tal película está en stock en una tienda en específico.
-- Ejemplo:
SELECT inventory_in_stock(5, 3); 
-- Verifica si la película con id:5 tien stock en la tienda con id:3
SELECT inventory_in_stock(2, 1); 
-- Verifica si la película con id:2 tien stock en la tienda con id:1

-- Esta consulta devuelve true si hay stock de la pelicula y false si no hay.


-- Procedimiento film_in_stock:
-- Este procedimiento se utiliza para verificar si una película en especifico tiene en stock en una tienda en especifico y 
-- si ese es el caso  muestra la información de la película y del inventario.
-- Ejemplo:
CALL film_in_stock(5, 3); 
-- Verifica y muestra información sobre la película con id:5 en la tienda con id:3
CALL film_in_stock(2, 1); 
-- Verifica y muestra información sobre la película con id:2 en la tienda con id:1


-- Este llamado  mostrará la información de la película y del inventario si es que esta disponible, 
-- o mostrará un mensaje indicando que la película no está disponible.