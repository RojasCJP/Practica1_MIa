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
insert into Inventario(
    id_entrega,
    id_tienda
)select distinct
    (select id_entrega from Entrega where titulo = Temporal.nombre_pelicula),
    (select id_tienda from Tienda where nombre = Temporal.nombre_tienda)
from Temporal where nombre_pelicula != '-' and nombre_tienda != '-';