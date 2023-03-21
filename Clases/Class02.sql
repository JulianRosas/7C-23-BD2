drop database imdb if exists;
CREATE DATABASE imdb;
use imdb;

drop table film if exists;
create table film(
    id int AUTO_INCREMENT primary key,
    title varchar(20),
    description varchar(50),
    release_year year
);

drop table actor if exists;
create table actor(
    id int AUTO_INCREMENT primary key,
    first_name varchar(20),
    last_name varchar(50)
);

drop table film_actor if exists;
create table film_actor(
    id int AUTO_INCREMENT primary key,
    id_film int, 
    id_actor int
);

alter table film add COLUMN last_update VARCHAR(54);
alter table actor add COLUMN last_update VARCHAR(54);

alter table film_actor add FOREIGN key (id_actor) references actor(id);
alter table film_actor add FOREIGN key (id_film) references film(id);

insert into  film(title, description, release_year) values ("Mision imposible", "pelicula de accion y suspenso", 2013);
insert into  film(title, description, release_year) values ("Mision imposible 2", "pelicula de accion y suspenso 2", 2015);
insert into  film(title, description, release_year) values ("Mision imposible 3", "pelicula de accion y suspenso 3", 2017);

insert into  actor(first_name, last_name) values ("tom ", "cruise");
insert into  actor(first_name, last_name) values ("mateo", "sinches");
insert into  actor(first_name, last_name) values ("franco", "ball");

insert into  film_actor(id_film, id_actor) values (1, 2);
insert into  film_actor(id_film, id_actor) values (2, 3);
insert into  film_actor(id_film, id_actor) values (3, 1);