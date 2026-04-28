from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.enemy_service import (
    get_enemies as fetch_enemies,
    get_enemies_by_location as fetch_enemies_by_location
)

enemy_bp = Blueprint("enemy", __name__)


@enemy_bp.route("/enemies", methods=["GET"])
def get_enemies():
    conn = None
    try:
        conn = db_conn()
        data = fetch_enemies(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()

@enemy_bp.route("/enemies/location/<int:location_id>", methods=["GET"])
def get_enemies_by_location(location_id):
    conn = None
    try:
        conn = db_conn()
        data = fetch_enemies_by_location(conn, location_id)
        return jsonify(data)
    finally:
        if conn:
            conn.close()