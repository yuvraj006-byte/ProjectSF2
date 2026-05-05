from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.enemy_drop_service import (
    get_enemy_drops as fetch_enemy_drops,
    get_drops_by_enemy as fetch_drops_by_enemy
)

enemy_drop_bp = Blueprint("enemy_drop", __name__)

@enemy_drop_bp.route("/enemy-drops", methods=["GET"])
def get_enemy_drops():
    conn = None
    try:
        conn = db_conn()
        data = fetch_enemy_drops(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()


@enemy_drop_bp.route("/enemy-drops/enemy/<int:enemy_id>", methods=["GET"])
def get_drops_by_enemy(enemy_id):
    conn = None
    try:
        conn = db_conn()
        data = fetch_drops_by_enemy(conn, enemy_id)
        return jsonify(data)
    finally:
        if conn:
            conn.close()