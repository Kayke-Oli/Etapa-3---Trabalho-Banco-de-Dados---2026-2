import mysql.connector
from mysql.connector import Error
import os

def conectar():
    try:
        connection = mysql.connector.connect(
            host="200.235.131.219",
            database="grupo5",
            user="grupo5",
            password=os.getenv("MYSQL_PASSWORD")
        )
        if connection.is_connected():
            print("Conexão bem sucedida\n")
            return connection

    except Error as e:
        print(f"Erro ao conectar ao MySQL: {e}")
        return None