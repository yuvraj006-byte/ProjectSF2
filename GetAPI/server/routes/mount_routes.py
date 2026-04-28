from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.mount_service import get_mounts as fetch_mounts

mount_bp = Blueprint("mount", __name__)


@mount_bp.route("/mounts", methods=["GET"])
def get_mounts():
    conn = None
    try:
        conn = db_conn()
        data = fetch_mounts(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()