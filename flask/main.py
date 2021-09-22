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
    prueba = await conection_db()
    return jsonify(prueba)


if __name__ == '__main__':
    app.run(debug=True)
# conection_db()
