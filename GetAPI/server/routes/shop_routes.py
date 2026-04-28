from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.shop_service import (
    get_shops as fetch_shops,
    get_shops_by_location as fetch_shops_by_location
)

shop_bp = Blueprint("shop", __name__)

@shop_bp.route("/shops", methods=["GET"])
def get_shops():
    conn = None
    try:
        conn = db_conn()
        data = fetch_shops(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()


@shop_bp.route("/shops/location/<int:location_id>", methods=["GET"])
def get_shops_by_location(location_id):
    conn = None
    try:
        conn = db_conn()
        data = fetch_shops_by_location(conn, location_id)
        return jsonify(data)
    finally:
        if conn:
            conn.close()