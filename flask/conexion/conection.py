import psycopg2
import psycopg2.extras

DB_HOST = 'localhost'
DB_NAME = 'practica1'
DB_USER = 'postgres'
DB_PASS = 'password'


def selects(query, conection):
    cursor = conection.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cursor.execute(query)
    salida = cursor.fetchall()
    cursor.close()
    return salida


def inserts(query, conection):
    cursor = conection.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cursor.execute(query)
    cursor.close()


async def conection_db():
    conection = psycopg2.connect(dbname=DB_NAME,
                                 user=DB_USER,
                                 password=DB_PASS,
                                 host=DB_HOST)
    # inserts("INSERT INTO pais (nombre) VALUES('El Salvador')", conection)
    select = selects("select * from pais;", conection)
    print(select[0]["nombre"])
    conection.commit()
    conection.close()
    return select
