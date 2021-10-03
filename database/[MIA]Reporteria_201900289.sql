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
having count(*) >= 40;
-- 3
select
    CONCAT(nombre, ' ', apellido) as nombre_completo
from Actor
where apellido like '%son%' or apellido like 'Son%'
order by nombre;
-- 4
-- TODO preguntar sobre si son las 2 o solo una
select distinct entrega.lanzamiento, actor.nombre, actor.apellido from actorentrega 
inner join entrega on entrega.id_entrega = actorentrega.id_entrega
inner join actor on actor.id_actor = actorentrega.id_actor
where entrega.descripcion like '%Crocodile%' or
entrega.descripcion like '%Shark%'
order by actor.apellido asc;
-- 5
-- TODO es de cada pais 
with COSTOPAIS as (
    select sum(renta.monto_pagar)as suma, pais.nombre from pais
    inner join ciudad on pais.id_pais = ciudad.id_pais
    inner join direccion on ciudad.id_ciudad = direccion.id_ciudad
    inner join cliente on cliente.id_direccion = direccion.id_direccion
    inner join renta on renta.id_cliente = cliente.id_cliente
    group by pais.id_pais
), AUXILIAR as(
    select
        pais.nombre as pais,
        cliente.nombre,
        cliente.apellido,
        sum(renta.monto_pagar) as pago_persona,
        COSTOPAIS.suma as pago_pais,
        count(*) as rentas,
        (sum(renta.monto_pagar)/COSTOPAIS.suma)*100 as porcentaje,
        row_number() over (partition by pais.nombre order by count(*) desc) as rank
    from Renta cross join COSTOPAIS
    inner join cliente on cliente.id_cliente = renta.id_cliente
    inner join direccion on cliente.id_direccion = direccion.id_direccion
    inner join ciudad on direccion.id_ciudad = ciudad.id_ciudad
    inner join pais on ciudad.id_pais = pais.id_pais 
    GROUP BY cliente.nombre, cliente.apellido, COSTOPAIS.suma, COSTOPAIS.nombre, pais.nombre
    having COSTOPAIS.nombre = pais.nombre
    order by count(*) desc
) select AUXILIAR.pais, AUXILIAR.nombre,AUXILIAR.apellido, AUXILIAR.porcentaje from COSTOPAIS 
inner join AUXILIAR on COSTOPAIS.nombre = AUXILIAR.pais
where AUXILIAR.rank = 1;
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
    GROUP by pais.nombre, pais.id_pais
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
)select RENTAPAIS.nombre as nombre_pais, RENTACIUDAD.nombre as nombre_ciudad, cast(RENTAPAIS.rentas as float)/CIUDADESPAIS.cantidad as promedio
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
)select RENTASTOTALES.nombre, (cast(RENTASSPORTS.rentas as float)/RENTASTOTALES.rentas)*100 as porcentaje
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
)select ciudad, pais, contador from TOPS 
where rank = 1
and categoria = 'Horror';