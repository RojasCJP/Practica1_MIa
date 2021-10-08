with A as(
select count(*) as cu from ActorEntrega
), B as(
select count(*) as cu from Actor
), C as(
select count(*) as cu from CategoriaEntrega
), D as(
select count(*) as cu from Categoria
), E as(
select count(*) as cu from Renta
), F as(
select count(*) as cu from Inventario
), G as(
select count(*) as cu from Pelicula
), H as(
select count(*) as cu from Lenguaje
), I as(
select count(*) as cu from Entrega
), J as(
select count(*) as cu from Clasificacion
), K as(
select count(*) as cu from Cliente
), L as(
select count(*) as cu from Tienda
), M as(
select count(*) as cu from Empleado
), N as(
select count(*) as cu from UsuarioEmpleado
), O as(
select count(*) as cu from TipoEmpleado
), P as(
select count(*) as cu from Direccion
), Q as(
select count(*) as cu from Ciudad
), R as(
select count(*) as cu from Pais
), S as(
select count(*) as cu from Temporal
)select 
    A.cu as actentrega,
    B.cu as actor,
    C.cu as catentrega,
    D.cu as categoria,
    E.cu as renta,
    F.cu as inventario,
    G.cu as pelicula,
    H.cu as lenguaje,
    I.cu as entrega,
    J.cu as clasificacion,
    K.cu as cliente,
    L.cu as tienda,
    M.cu as empleado,
    N.cu as usempleado,
    O.cu as tipo_empleado,
    P.cu as direccion,
    Q.cu as ciudad,
    R.cu as pais,
    S.cu as temporal
from A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S;