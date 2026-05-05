import mysql.connector

def db_conn():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Cat",
        database="Game2"
    )