from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.item_service import (
    get_items as fetch_items,
    get_items_by_type as fetch_items_by_type
)

item_bp = Blueprint("item", __name__)


@item_bp.route("/items", methods=["GET"])
def get_items():
    conn = None
    try:
        conn = db_conn()
        data = fetch_items(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()

@item_bp.route("/items/type/<string:item_type>", methods=["GET"])
def get_items_by_type(item_type):
    conn = None
    try:
        conn = db_conn()
        data = fetch_items_by_type(conn, item_type)
        return jsonify(data)
    finally:
        if conn:
            conn.close()




