--------------------------------------------------------------------------Guia 19-------------------------------------------------------------------------------
--Ej1
create user data_analyst identified by 'pepe1234';

--Ej2
GRANT select, update, delete on sakila.* to 'data_analyst'@'%';

--Ej3
-- Iniciamos sesion en el usuario con el siguiente comando: mysql -udata_analyst -ppepe1234 
create table Messi(id int primary key, nombre varchar(20), goles int, dorsal int);
--No te deja, ya que cuando le diste los permisos no le diste el poder de crear una tabla

--Ej4
update film set title = 'La razon de estar contigo' where film_id=9;
--Se updatea de forma correcta

--Ej5
REVOKE update on sakila.* from data_analyst;

--Ej6
update film set title = 'La razon de estar contigo 2' where film_id=9;
--Nos da error, ya que en el ejercicio anterior le sacamos el permiso update que le habiamos dado anteriormente