from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.location_service import (
    get_empire as fetch_empire,
    get_nation as fetch_nation,
    get_nations_by_empire as fetch_nations_by_empire,
)

location_bp = Blueprint("location", __name__)


@location_bp.route("/empire", methods=["GET"])
def get_empires():
    conn = None
    try:
        conn = db_conn()
        data = fetch_empire(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()


@location_bp.route("/nation", methods=["GET"])
def get_nations():
    conn = None
    try:
        conn = db_conn()
        data = fetch_nation(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()

# Nested route: nations belonging to a specific empire
@location_bp.route("/empire/<int:empire_id>/nation", methods=["GET"])
def get_nations_by_empire(empire_id):
    conn = None
    try:
        conn = db_conn()
        data = fetch_nations_by_empire(conn, empire_id)
        return jsonify(data)
    finally:
        if conn:
            conn.close()
