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
