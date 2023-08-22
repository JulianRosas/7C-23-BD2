------------------------------------------------------------------------GUIA 16------------------------------------------------------------------------------

--Ej1

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 
(1009,'Kevin','Tuckson','x5940',null,'6',NULL,'ceo');
-- Column 'email' cannot be null
--El error nos esta diciendo que el campo email no puede ser nulo, por lo tanto hay que poner si o si un email

--Ej2
update employees set employeeNumber = employeeNumber - 20
-- Esta query nos da como resultado una reduccion de employeeNumber en 20 numeros

update employees set employeeNumber = employeeNumber + 20
-- Al runear esta query nos da el siguiente error: Duplicate entry '1056' for key 'employees.PRIMARY'
-- Este error nos esta diciendo que hay dos employees que se llevan 20 numeros
-- Cuando se le suman los 20 numeros al primer employee nos queda el mismo numero que el que tiene el segundo employee, por lo tanto da error.ABORT

--Ej3
alter table employees add column age int check(age >= 16 and age <= 70);

--Ej4
-- La tabla film_actor funciona como una tabla intermedia entre la tabla film y la tabla actor, esto logra que la relacion
-- muchos a muchos funcione. Los actores participan en varias peliculas, por lo tanto en la tabla film_actor se conecta el el id
-- de la pelicula con el id del actor.

--Ej5
alter table employees add column lastUpdate datetime;

alter table employees add lastUpdateUser varchar(50);

DELIMITER $$
create trigger before_employees_update before update on employees for each row 
begin
  set NEW.lastUpdate = now();
  SET NEW.lastUpdateUser = CURRENT_USER;
end$$
create trigger before_employees_insert before insert on employeesfor each row 
begin
  set NEW.lastUpdate = now();
  SET NEW.lastUpdateUser = CURRENT_USER;
end$$
delimeter ;

--Ej6
SHOW TRIGGERS FROM sakila;

CREATE DEFINER=`user`@`%` TRIGGER `ins_film`  AFTER INSERT ON `film` FOR EACH ROW 
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END

-- ins_film: despues de insertar un valor, este trigger inserta el film_id,title y la description a film_text.

CREATE DEFINER=`user`@`%` TRIGGER `upd_film`
    AFTER UPDATE ON `film`
    FOR EACH ROW
BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END

-- upd_film: cuando se actualiza el titulo, film_id o description de una pelicula, esta trigger actualiza el film_text
--cambiando tambien el title, description y film_id.

  CREATE DEFINER=`user`@`%` TRIGGER `del_film`
    AFTER DELETE ON `film`
    FOR EACH ROW
  BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END

-- del_film: borra el film_text de una pelicula que fue borrada.