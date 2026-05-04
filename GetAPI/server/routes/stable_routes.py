from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.stable_service import (
    get_stables as fetch_stables,
    get_stables_by_location as fetch_stables_by_location
)

stable_bp = Blueprint("stable", __name__)

@stable_bp.route("/stables", methods=["GET"])
def get_stables():
    conn = None
    try:
        conn = db_conn()
        data = fetch_stables(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()


@stable_bp.route("/stables/location/<int:location_id>", methods=["GET"])
def get_stables_by_location(location_id):
    conn = None
    try:
        conn = db_conn()
        data = fetch_stables_by_location(conn, location_id)
        return jsonify(data)
    finally:
        if conn:
            conn.close()