from conexion.conection import *
from flask import *
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

app = Flask(__name__)
# app.config[
#     'SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:password@localhost/practica1'

# db = SQLAlchemy(app)

# class Pais(db.Model):
#     __tablename__ = 'pais'
#     id = db.Column(db.Integer, primary_key=True)
#     name = db.Column(db.String(150))

#     def __init__(self, idd, name):
#         self.id = idd
#         self.name = name


@app.route('/', methods=['GET'])
async def index():
    prueba = await conection_db(CONSULTA1)
    return jsonify(prueba)


@app.route('/consulta1', methods=['GET'])
async def consulta1():
    consulta = await conection_db(CONSULTA1)
    return jsonify(consulta)


@app.route('/consulta2', methods=['GET'])
async def consulta2():
    consulta = await conection_db(CONSULTA2)
    return jsonify(consulta)


@app.route('/consulta3', methods=['GET'])
async def consulta3():
    consulta = await conection_db(CONSULTA3)
    return jsonify(consulta)


@app.route('/consulta4', methods=['GET'])
async def consulta4():
    consulta = await conection_db(CONSULTA4)
    return jsonify(consulta)


@app.route('/consulta42', methods=['GET'])
async def consulta42():
    consulta = await conection_db(CONSULTA42)
    return jsonify(consulta)


@app.route('/consulta5', methods=['GET'])
async def consulta5():
    consulta = await conection_db(CONSULTA5)
    return jsonify(consulta)


@app.route('/consulta6', methods=['GET'])
async def consulta6():
    consulta = await conection_db(CONSULTA6)
    return jsonify(consulta)


@app.route('/consulta7', methods=['GET'])
async def consulta7():
    consulta = await conection_db(CONSULTA7)
    return jsonify(consulta)


@app.route('/consulta72', methods=['GET'])
async def consulta72():
    consulta = await conection_db(CONSULTA72)
    return jsonify(consulta)


@app.route('/consulta8', methods=['GET'])
async def consulta8():
    consulta = await conection_db(CONSULTA8)
    return jsonify(consulta)


@app.route('/consulta9', methods=['GET'])
async def consulta9():
    consulta = await conection_db(CONSULTA9)
    return jsonify(consulta)


@app.route('/consulta10', methods=['GET'])
async def consulta10():
    consulta = await conection_db(CONSULTA10)
    return jsonify(consulta)


@app.route('/eliminarTemporal', methods=['GET'])
async def eliminarTemporal():
    await conection_db(ELIMINARTEMPORAL)
    return {"respuesta": "tabla temporal eliminada correctamente"}


@app.route('/elminarModelo', methods=['GET'])
async def eliminarModelo():
    await conection_db(ELIMINARMODELO)
    return {"respuesta": "se ha eliminado el modelo correctamente"}


@app.route('/cargarTemporal', methods=['GET'])
async def cargarTemporal():
    await conection_db(CARGAMASIVA)
    return {"respuesta": "se ha realizado la carga masiva"}


@app.route('/cargarModelo', methods=['GET'])
async def cargarModelo():
    await conection_db(CARGAMODELO)
    return {"respuesta": "se cargo el modelo correctamente"}


@app.route('/counts', methods=['GET'])
async def counts():
    consulta = await conection_db(COUNTS)
    return jsonify(consulta)


if __name__ == '__main__':
    app.run(debug=True)
# conection_db()
