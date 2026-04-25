from flask import g
import mysql.connector
from dotenv import load_dotenv
import os

load_dotenv()

db_host = os.getenv("DB_HOST")
db_user = os.getenv("DB_USER")
db_pass = os.getenv("DB_PASSWORD")
db_port = os.getenv("DB_PORT")
db_name = os.getenv("DB_NAME")


def db_conn():
    if "db" not in g:
        g.db = mysql.connector.connect(
            host=db_host,
            port=int(db_port),
            database=db_name,
            user=db_user,
            password=db_pass,
            autocommit=True
        )
    return g.db


def close_connection(e=None):
    conn = g.pop("db", None)

    if conn is not None:
        conn.close()
