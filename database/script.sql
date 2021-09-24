-- creacion de base de datos
create database Practica1;
use Practica1;

-- eliminacion de tablas
drop table ActorEntrega;
drop table Actor;
drop table CategoriaEntrega;
drop table CAtegoria;
drop table Renta;
drop table Inventario;
drop table Pelicula;
drop table Lenguaje;
drop table Entrega;
drop table Clasificacion;
drop table Cliente;
drop table Tienda;
drop table Empleado;
drop table UsuarioEmpleado;
drop table TipoEmpleado;
drop table Direccion;
drop table Ciudad;
drop table Pais;
drop table Temporal;



-- creacion de tabla temporal
create table Temporal(
    nombre_cliente varchar(50),
    correo_cliente varchar(60),
    cliente_activo varchar(5),
    fecha_creacion varchar(30),
    tienda_preferida varchar(40),
    direccion_cliente varchar(80),
    codigo_postal_cliente varchar(10),
    ciudad_cliente varchar(40),
    pais_cliente varchar(40),
    fecha_renta varchar(30),
    fecha_retorno varchar(30),
    monto_pagar varchar(10),
    fecha_pago varchar(30),
    nombre_empleado varchar(50),
    correo_empleado varchar(60),
    empleado_activo varchar(5),
    tienda_empleado varchar(40),
    usuario_empleado varchar(50),
    contrasena_empleado varchar(100),
    direccion_empleado varchar(80),
    codigo_postal_empleado varchar(10),
    ciudad_empleado varchar(40),
    pais_empleado varchar(40),
    nombre_tienda varchar(40),
    encargado_tienda varchar(40),
    direccion_tienda varchar(80),
    codigo_postal_tienda varchar(10),
    ciudad_tienda varchar(40),
    pais_tienda varchar(40),
    tienda_pelicula varchar(40),
    nombre_pelicula varchar(50),
    descripcion_pelicula varchar(250),
    lanzamiento varchar(10),
    dias_renta varchar(5),
    costo_renta varchar(10),
    duracion varchar(10),
    costo_dano_renta varchar(10),
    clasificacion varchar(5),
    lenguaje_pelicula varchar(10),
    categoria_pelicula varchar(20),
    actor_pelicula varchar(50)
);

-- creacion de tablas db
create table Pais(
    id_pais int generated always as identity primary key,
    nombre varchar(150) not null
);
create table Ciudad(
    id_ciudad int generated always as identity primary key,
    nombre varchar(150) not null,
    id_pais int not null,
    foreign key (id_pais) references Pais(id_pais)
);
create table Direccion(
    id_direccion int generated always as identity primary key,
    direccion varchar(150) not null,
    id_ciudad int,
    distrito varchar(150),
    codigo_postal int,
    foreign key (id_ciudad) references Ciudad(id_ciudad)
);
create table TipoEmpleado(
    id_tipo int generated always as identity primary key,
    tipo varchar(10)
);
create table UsuarioEmpleado(
    id_usuario_empleado int generated always as identity primary key,
    usuario varchar(150) not null,
    contrasena varchar(150) not null
);
create table Empleado(
    id_empleado int generated always as identity primary key,
    nombre varchar(150) not null,
    apellido varchar(150) not null,
    id_direccion int not null,
    email varchar(150) not null,
    activo boolean not null,
    id_tipo int not null,
    id_usuario_empleado int not null,
    foreign key (id_direccion) references Direccion(id_direccion),
    foreign key (id_tipo) references TipoEmpleado(id_tipo),
    foreign key (id_usuario_empleado) references UsuarioEmpleado(id_usuario_empleado)
);
create table Tienda(
    id_tienda int generated always as identity primary key,
    nombre varchar(150) not null,
    id_direccion int not null,
    foreign key (id_direccion) references Direccion(id_direccion)
);
create table Cliente(
    id_cliente int generated always as identity primary key,
    nombre varchar(150) not null,
    apellido varchar(150),
    email varchar(150),
    id_direccion int not null,
    fecha_registro date,
    activo boolean not null,
    id_tienda_favorita int,
    foreign key (id_direccion) references Direccion(id_direccion),
    foreign key (id_tienda_favorita) references Tienda(id_tienda)
);
create table Clasificacion(
    id_clasificacion int generated always as identity primary key,
    clasificacion varchar(10) not null
);
create table Entrega(
    id_entrega int generated always as identity primary key,
    titulo varchar(150) not null,
    descripcion varchar(150) not null,
    lanzamiento int,
    duracion int,
    id_clasificacion int not null,
    foreign key (id_clasificacion) references Clasificacion(id_clasificacion)
);
create table Lenguaje(
    id_lenguaje int generated always as identity primary key,
    lenguaje varchar(150) not null
);
create table Pelicula(
    id_pelicula int generated always as identity primary key,
    dias_renta int,
    costo_renta float,
    costo_dano_renta float,
    id_lenguaje int not null,
    id_entrega int not null,
    foreign key (id_lenguaje) references Lenguaje(id_lenguaje),
    foreign key (id_entrega) references Entrega(id_entrega)
);
create table Inventario(
    id_inventario int generated always as identity primary key,
    id_pelicula int not null,
    id_tienda int not null,
    foreign key (id_pelicula) references Pelicula(id_pelicula),
    foreign key (id_tienda) references Tienda(id_tienda)
);
create table Renta(
    id_renta int generated always as identity primary key,
    fecha_renta date not null,
    fecha_retorno date,
    monto_patar float not null,
    fecha_pago date,
    id_cliente int,
    id_empleado int,
    id_tienda int,
    id_pelicula int,
    foreign key (id_cliente) references Cliente(id_cliente),
    foreign key (id_empleado) references Empleado(id_empleado),
    foreign key (id_tienda) references Tienda(id_tienda),
    foreign key (id_pelicula) references Pelicula(id_pelicula)
);
create table Categoria(
    id_categoria int generated always as identity primary key,
    categoria varchar(150)
);
create table CategoriaEntrega(
    id_categoria_entrega int generated always as identity primary key,
    id_categoria int,
    id_entrega int,
    foreign key (id_categoria) references Categoria(id_categoria),
    foreign key (id_entrega) references Entrega(id_entrega)
);
create table Actor(
    id_actor int generated always as identity primary key,
    nombre varchar(150),
    apellido varchar(150)
);
create table ActorEntrega(
    id_actor_entrega int generated always as identity primary key,
    id_actor int,
    id_entrega int,
    foreign key (id_actor) references Actor(id_actor),
    foreign key (id_entrega) references Entrega(id_entrega)
);

-- insertar a temporal
COPY Temporal
FROM '/home/juanpa/Documents/Archivos/Laboratorio/Practica1_MIa/BlockbusterData.csv'
DELIMITER ';';

-- hacer null lo que tiene -
update Temporal set codigo_postal_cliente = null where codigo_postal_cliente = '-';
update Temporal set codigo_postal_empleado = null where codigo_postal_empleado = '-';
update Temporal set codigo_postal_tienda = null where codigo_postal_tienda = '-';
update Temporal set lanzamiento = null where lanzamiento = '-';
update Temporal set duracion = null where duracion = '-';

-- insertar a base de datos
-- pais
insert into Pais (nombre)
select distinct pais_cliente from Temporal where pais_cliente != '-'
and pais_cliente not in (select nombre from Pais);
insert into Pais (nombre)
select distinct pais_empleado from Temporal where pais_empleado != '-'
and pais_empleado not in (select nombre from Pais);
insert into Pais (nombre)
select distinct pais_tienda from Temporal where pais_tienda != '-'
and pais_tienda not in (select nombre from Pais);
-- actor
insert into Actor (nombre)
select distinct actor_pelicula from Temporal where actor_pelicula != '-';
-- tipo empleado
insert into TipoEmpleado (tipo) values ('encargado');
insert into TipoEmpleado (tipo) values ('normal');
-- usuario empleado
insert into UsuarioEmpleado (usuario, contrasena)
select distinct usuario_empleado , contrasena_empleado from Temporal where usuario_empleado != '-' and contrasena_empleado != '-';
-- clasificacion
insert into Clasificacion (clasificacion)
select distinct clasificacion from Temporal where Temporal.clasificacion != '-';
-- lenguaje
insert into Lenguaje (lenguaje)
select distinct lenguaje_pelicula from Temporal where lenguaje_pelicula != '-';
-- categoria
insert into Categoria (categoria)
select distinct categoria_pelicula from temporal where categoria_pelicula != '-';
-- ciudad 
insert into Ciudad (nombre, id_pais)
select distinct ciudad_cliente,(Select id_pais from Pais where nombre = Temporal.pais_cliente) from Temporal where ciudad_cliente != '-'
and ciudad_cliente not in (select nombre from Ciudad);
insert into Ciudad (nombre, id_pais)
select distinct ciudad_empleado, (Select id_pais from Pais where nombre = Temporal.pais_empleado) from Temporal where ciudad_empleado != '-'
and ciudad_empleado not in (select nombre from Ciudad);
insert into Ciudad (nombre, id_pais)
select distinct ciudad_tienda, (Select id_pais from Pais where nombre = Temporal.pais_tienda) from Temporal where ciudad_tienda != '-'
and ciudad_tienda not in (select nombre from Ciudad);
-- direccion
insert into Direccion (direccion, id_ciudad, codigo_postal)
select distinct direccion_cliente, (select id_ciudad from Ciudad inner join Pais 
                                     on Ciudad.id_pais = Pais.id_pais 
                                     where Ciudad.nombre = Temporal.ciudad_cliente 
                                     and Pais.nombre = Temporal.pais_cliente ), cast(codigo_postal_cliente as int) from Temporal where direccion_cliente != '-'
and direccion_cliente not in (select direccion from direccion);
insert into Direccion (direccion, id_ciudad, codigo_postal)
select distinct direccion_empleado, (select id_ciudad from Ciudad inner join Pais 
                                     on Ciudad.id_pais = Pais.id_pais 
                                     where Ciudad.nombre = Temporal.ciudad_empleado
                                     and Pais.nombre = Temporal.pais_empleado), cast(codigo_postal_empleado as int) from Temporal where direccion_empleado != '-'
and direccion_empleado not in (select direccion from direccion);
insert into Direccion (direccion, id_ciudad, codigo_postal)
select distinct direccion_tienda, (select id_ciudad from Ciudad inner join Pais 
                                     on Ciudad.id_pais = Pais.id_pais 
                                     where Ciudad.nombre = Temporal.ciudad_tienda 
                                     and Pais.nombre = Temporal.pais_tienda ), cast(codigo_postal_tienda as int) from Temporal where direccion_tienda != '-'
and direccion_tienda not in (select direccion from direccion);
-- tienda
insert into Tienda(nombre, id_direccion)
select distinct nombre_tienda, (select id_direccion from Direccion where direccion = Temporal.direccion_tienda) from Temporal where nombre_tienda != '-'
and nombre_tienda not in (select nombre from Tienda);
-- entrega
insert into Entrega(titulo, descripcion, lanzamiento, duracion, id_clasificacion)
select distinct nombre_pelicula, descripcion_pelicula, cast(lanzamiento as int), cast(duracion as int), (select id_clasificacion from Clasificacion where clasificacion = Temporal.clasificacion)
 from Temporal where nombre_pelicula != '-'
and nombre_pelicula not in (select titulo from Entrega);

-- encontrar repetidos
SELECT COUNT(E.*) as Repetidos, E.nombre
FROM Ciudad AS E 
GROUP BY E.nombre;