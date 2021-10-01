-- creacion de base de datos
create database Practica1;
use Practica1;

-- eliminacion de tablas
drop table ActorEntrega;
drop table Actor;
drop table CategoriaEntrega;
drop table Categoria;
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
    activo varchar(5) not null,
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
    apellido varchar(150)not null,
    email varchar(150),
    id_direccion int not null,
    fecha_registro date,
    activo varchar(5) not null,
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
    id_entrega int not null,
    id_tienda int not null,
    foreign key (id_entrega) references Entrega(id_entrega),
    foreign key (id_tienda) references Tienda(id_tienda)
);
create table Renta(
    id_renta int generated always as identity primary key,
    fecha_renta date not null,
    fecha_retorno date,
    monto_pagar float not null,
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
update Temporal set fecha_renta = null where fecha_renta = '-';
update Temporal set fecha_retorno = null where fecha_retorno = '-';
update Temporal set monto_pagar = null where monto_pagar = '-';
update Temporal set fecha_pago = null where fecha_pago = '-';

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
insert into Actor (nombre, apellido)
select distinct SPLIT_PART(actor_pelicula, ' ', 1), SPLIT_PART(actor_pelicula, ' ', 2) from Temporal where actor_pelicula != '-';
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
-- cliente
insert into Cliente(
    nombre,
    apellido,
    email,
    id_direccion,
    fecha_registro,
    activo,
    id_tienda_favorita
)
select distinct 
    SPLIT_PART(nombre_cliente, ' ',1),
    SPLIT_PART(nombre_cliente, ' ',2),
    correo_cliente, 
    (select id_direccion from Direccion where direccion = Temporal.direccion_cliente),
    cast(fecha_creacion as date),
    cliente_activo, 
    (select id_tienda from Tienda where nombre = Temporal.tienda_preferida)
from Temporal where nombre_cliente != '-'
and SPLIT_PART(nombre_cliente, ' ',1) not in (select nombre from Cliente);
-- empleado
insert into Empleado(
    nombre,
    apellido,
    id_direccion,
    email,
    activo,
    id_tipo,
    id_usuario_empleado
)
select distinct
    SPLIT_PART(nombre_empleado, ' ',1),
    SPLIT_PART(nombre_empleado, ' ',2),
    (select id_direccion from Direccion where direccion = Temporal.direccion_empleado),
    correo_empleado,
    empleado_activo,
    (case when nombre_empleado in (select encargado_tienda from Temporal) then 1 else 2 end),
    (select id_usuario_empleado from UsuarioEmpleado where usuario = Temporal.usuario_empleado)
from Temporal where nombre_empleado != '-'
and SPLIT_PART(nombre_empleado, ' ',1) not in (select nombre from Empleado);
-- pelicula 
insert into Pelicula(
    dias_renta,
    costo_renta,
    costo_dano_renta,
    id_lenguaje,
    id_entrega
)select distinct 
    cast(dias_renta as int),
    cast(costo_renta as float),
    cast(costo_dano_renta as float),
    (select id_lenguaje from Lenguaje where lenguaje = Temporal.lenguaje_pelicula),
    (select id_entrega from Entrega where titulo = Temporal.nombre_pelicula)
from Temporal where nombre_pelicula != '-';
-- renta
insert into Renta(
    fecha_renta,
    fecha_retorno,
    monto_pagar,
    fecha_pago,
    id_cliente,
    id_empleado,
    id_tienda,
    id_pelicula    
)select distinct
    cast(fecha_renta as date),
    cast(fecha_retorno as date),
    cast(monto_pagar as float),
    cast(fecha_pago as date),
    (select id_cliente from Cliente where CONCAT(nombre,' ',apellido) = Temporal.nombre_cliente),
    (select id_empleado from Empleado where CONCAT(nombre,' ',apellido) = Temporal.nombre_empleado),
    (select id_tienda from Tienda where nombre = Temporal.nombre_tienda),
    (select id_pelicula from Pelicula inner join Entrega on Pelicula.id_entrega = Entrega.id_entrega where Entrega.titulo = nombre_pelicula)
from Temporal where fecha_renta != '-';
-- actor entrega
insert into ActorEntrega(
    id_actor,
    id_entrega
)select distinct
    (select id_actor from Actor where CONCAT(nombre,' ',apellido) = Temporal.actor_pelicula),
    (select id_entrega from Entrega where titulo = Temporal.nombre_pelicula)
from Temporal where actor_pelicula != '-' and nombre_pelicula != '-';
-- categoria entrega
insert into CategoriaEntrega(
    id_categoria,
    id_entrega
)select distinct
    (select id_categoria from Categoria where categoria = Temporal.categoria_pelicula),
    (select id_entrega from Entrega where titulo = Temporal.nombre_pelicula)
from Temporal where categoria_pelicula != '-' and nombre_pelicula != '-';
-- inventario (pelicula tienda)
-- TODO tengo que ver si lo tenemos que hacer asi o si lo tenemos que ver tambien por fecha
insert into Inventario(
    id_entrega,
    id_tienda
)select distinct
    (select id_entrega from Entrega where titulo = Temporal.nombre_pelicula),
    (select id_tienda from Tienda where nombre = Temporal.nombre_tienda)
from Temporal where nombre_pelicula != '-' and nombre_tienda != '-';

-- encontrar repetidos
SELECT COUNT(E.*) as Repetidos, E.nombre
FROM Ciudad AS E 
GROUP BY E.nombre;

select COUNT (E.*) as Repetidos, E.id_entrega
from Pelicula as E
GROUP BY E.id_entrega
ORDER BY E.id_entrega ASC;

-- selects
-- 1
select count(*) from Inventario 
inner join Entrega on Entrega.id_entrega = Inventario.id_entrega 
where Entrega.titulo = 'SUGAR WONKA';
-- 2
select 
    cliente.nombre,
    cliente.apellido,
    sum(renta.monto_pagar) as pago_total
from Renta 
inner join cliente on cliente.id_cliente = renta.id_cliente 
GROUP BY cliente.nombre, cliente.apellido
having count(*) > 40;
-- 3
select
    CONCAT(nombre, ' ', apellido) as nombre_completo
from Actor
where apellido like '%son%' or apellido like 'Son%'
order by nombre;
-- 4
select distinct entrega.lanzamiento, actor.nombre, actor.apellido from actorentrega 
inner join entrega on entrega.id_entrega = actorentrega.id_entrega
inner join actor on actor.id_actor = actorentrega.id_actor
where entrega.descripcion like '%Crocodile%' or
entrega.descripcion like '%Shark%'
order by actor.apellido;
-- 5
with COSTOPAIS as (
    select sum(renta.monto_pagar)as suma, pais.nombre from pais
    inner join ciudad on pais.id_pais = ciudad.id_pais
    inner join direccion on ciudad.id_ciudad = direccion.id_ciudad
    inner join cliente on cliente.id_direccion = direccion.id_direccion
    inner join renta on renta.id_cliente = cliente.id_cliente
    group by pais.id_pais
)
select
    cliente.nombre,
    cliente.apellido,
    sum(renta.monto_pagar) as pago_persona,
    COSTOPAIS.suma as pago_pais,
    count(*) as rentas,
    (sum(renta.monto_pagar)/COSTOPAIS.suma)*100 as porcentaje
from Renta cross join COSTOPAIS
inner join cliente on cliente.id_cliente = renta.id_cliente
inner join direccion on cliente.id_direccion = direccion.id_direccion
inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
inner join pais on ciudad.id_pais = pais.id_pais 
GROUP BY cliente.nombre, cliente.apellido, COSTOPAIS.suma, COSTOPAIS.nombre, pais.nombre
having COSTOPAIS.nombre = pais.nombre
order by count(*) desc
limit 1;
-- 6
with CLIENTESCIUDAD as(
    select count(cliente.id_cliente)as clientes, ciudad.nombre as nombre, ciudad.id_pais from Ciudad
    inner join Direccion on Direccion.id_ciudad = Ciudad.id_ciudad
    inner join Cliente on Cliente.id_direccion = Direccion.id_direccion
    group by ciudad.id_pais, ciudad.nombre
), CLIENTESPAIS as(
    select count(cliente.id_cliente)as clientes, pais.nombre as nombre, pais.id_pais from Pais
    inner join Ciudad on Ciudad.id_pais = Pais.id_pais
    inner join Direccion on Direccion.id_ciudad = Ciudad.id_ciudad
    inner join Cliente on Cliente.id_direccion = Direccion.id_direccion
    group by pais.nombre, pais.id_pais
)select 
CLIENTESCIUDAD.nombre as nombre_ciudad,
CLIENTESCIUDAD.clientes as clientes_ciudad,
CLIENTESPAIS.nombre as nombre_pais,
CLIENTESPAIS.clientes as clientes_pais, 
(cast(CLIENTESCIUDAD.clientes as float)/CLIENTESPAIS.clientes)*100 as porcentaje
from CLIENTESCIUDAD
inner join CLIENTESPAIS on CLIENTESCIUDAD.id_pais = CLIENTESPAIS.id_pais;
-- 7
with RENTAPAIS as (   
    select count(renta.monto_pagar) as rentas, pais.nombre, pais.id_pais from renta
    inner join cliente on cliente.id_cliente = renta.id_cliente
    inner join direccion on cliente.id_direccion = direccion.id_direccion
    inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
    inner join pais on ciudad.id_pais = pais.id_pais
    GROUP by pais.id_pais, pais.nombre
), RENTACIUDAD as(
    select count(renta.monto_pagar) as rentas, ciudad.nombre, ciudad.id_pais from renta
    inner join cliente on cliente.id_cliente = renta.id_cliente
    inner join direccion on cliente.id_direccion = direccion.id_direccion
    inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
    group by ciudad.id_ciudad, ciudad.nombre, ciudad.id_pais
), CIUDADESPAIS as (
    select count(*) as cantidad, pais.id_pais from pais
    inner join ciudad on ciudad.id_pais = pais.id_pais
    group by ciudad.id_pais, pais.id_pais
)select RENTAPAIS.nombre as nombre_pais, RENTACIUDAD.nombre as nombre_ciudad, cast(RENTAPAIS.rentas as float)/CIUDADESPAIS.cantidad as rentas
from RENTAPAIS
inner join RENTACIUDAD on RENTACIUDAD.id_pais = RENTAPAIS.id_pais
inner join CIUDADESPAIS on CIUDADESPAIS.id_pais = RENTAPAIS.id_pais;
-- 8
with RENTASTOTALES as(
    select count(renta.monto_pagar) as rentas, pais.nombre, pais.id_pais from renta
    inner join cliente on cliente.id_cliente = renta.id_cliente
    inner join direccion on cliente.id_direccion = direccion.id_direccion
    inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
    inner join pais on ciudad.id_pais = pais.id_pais
    GROUP by pais.id_pais, pais.nombre
), RENTASSPORTS as(
    select count(renta.monto_pagar) as rentas, pais.nombre, pais.id_pais from renta
    inner join cliente on cliente.id_cliente = renta.id_cliente
    inner join direccion on cliente.id_direccion = direccion.id_direccion
    inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
    inner join pais on ciudad.id_pais = pais.id_pais
    inner join pelicula on renta.id_pelicula = pelicula.id_pelicula
    inner join entrega on entrega.id_entrega = pelicula.id_entrega
    inner join categoriaentrega on categoriaentrega.id_entrega = entrega.id_entrega
    inner join categoria on categoriaentrega.id_categoria = categoria.id_categoria
    GROUP by pais.id_pais, pais.nombre, categoria.categoria
    having categoria.categoria = 'Sports'
)select RENTASTOTALES.nombre, (cast(RENTASSPORTS.rentas as float)/RENTASTOTALES.rentas)*100, RENTASTOTALES.id_pais 
from RENTASTOTALES 
inner join RENTASSPORTS on RENTASTOTALES.id_pais = RENTASSPORTS.id_pais;
-- 9
with CIUDADESLISTADO as(
    select ciudad.nombre, ciudad.id_ciudad, ciudad.id_pais from Ciudad
    inner join Pais on pais.id_pais = ciudad.id_pais
    where pais.nombre = 'United States'
),RENTASCIUDADES as(
    select count(renta.monto_pagar) as rentas, ciudad.nombre, ciudad.id_ciudad, ciudad.id_pais from renta
    inner join cliente on cliente.id_cliente = renta.id_cliente
    inner join direccion on cliente.id_direccion = direccion.id_direccion
    inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
    inner join pais on ciudad.id_pais = pais.id_pais
    group by ciudad.nombre, ciudad.id_ciudad, ciudad.id_pais, pais.nombre
    having pais.nombre = 'United States'
),RENTASDAYTON as(
    select count(renta.monto_pagar) as rentas, ciudad.nombre, ciudad.id_ciudad, ciudad.id_pais from renta
    inner join cliente on cliente.id_cliente = renta.id_cliente
    inner join direccion on cliente.id_direccion = direccion.id_direccion
    inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
    group by ciudad.nombre, ciudad.id_ciudad, ciudad.id_pais
    having ciudad.nombre = 'Dayton'
)select CIUDADESLISTADO.nombre, RENTASCIUDADES.rentas from CIUDADESLISTADO
inner join RENTASCIUDADES on CIUDADESLISTADO.id_ciudad = RENTASCIUDADES.id_ciudad
inner join RENTASDAYTON on CIUDADESLISTADO.id_pais = RENTASDAYTON.id_pais
where RENTASCIUDADES.rentas > RENTASDAYTON.rentas;
-- 10
with TOPS as(
select 
    ciudad.nombre as ciudad,
    pais.nombre as pais,
    categoria.categoria,
    count(categoria.categoria) as contador,
    row_number() over (partition by ciudad.nombre order by count(categoria.categoria) desc) as rank
from renta
inner join cliente on cliente.id_cliente = renta.id_cliente
inner join direccion on cliente.id_direccion = direccion.id_direccion
inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
inner join pais on ciudad.id_pais = pais.id_pais
inner join pelicula on renta.id_pelicula = pelicula.id_pelicula
inner join entrega on entrega.id_entrega = pelicula.id_entrega
inner join categoriaentrega on categoriaentrega.id_entrega = entrega.id_entrega
inner join categoria on categoriaentrega.id_categoria = categoria.id_categoria
group by ciudad.id_ciudad, ciudad.nombre, pais.nombre, categoria.categoria
)select * from TOPS 
where rank = 1
and categoria = 'Horror';
-- pruebas
select cliente.nombre, cliente.apellido, pais.nombre from cliente
inner join direccion on cliente.id_direccion = direccion.id_direccion
inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
inner join pais on ciudad.id_pais = pais.id_pais
where cliente.nombre = 'Tim';



select sum(renta.monto_pagar), pais.nombre, cliente.nombre from pais
inner join ciudad on pais.id_pais = ciudad.id_pais
inner join direccion on ciudad.id_ciudad = direccion.id_ciudad
inner join cliente on cliente.id_direccion = direccion.id_direccion
inner join renta on renta.id_cliente = cliente.id_cliente
group by pais.id_pais, cliente.nombre, cliente.apellido
order by pais.nombre;

(select sum(renta.monto_pagar), pais.nombre from pais
inner join ciudad on pais.id_pais = ciudad.id_pais
inner join direccion on ciudad.id_ciudad = direccion.id_ciudad
inner join cliente on cliente.id_direccion = direccion.id_direccion
inner join renta on renta.id_cliente = cliente.id_cliente
group by pais.id_pais
having pais.nombre = 'India');