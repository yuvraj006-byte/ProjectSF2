from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.score_service import get_character_score

score_bp = Blueprint("score", __name__)


@score_bp.route("/characters/<int:character_id>/score", methods=["GET"])
def get_score(character_id):
    conn = None
    try:
        conn = db_conn()
        data = get_character_score(conn, character_id)
        return jsonify(data)
    finally:
        if conn:
            conn.close()