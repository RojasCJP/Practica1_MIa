delete from Temporal;
drop table Temporal;

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

COPY Temporal
FROM '/home/juanpa/Documents/Archivos/Laboratorio/Practica1_MIa/BlockbusterData.csv'
DELIMITER ';'
CSV HEADER;