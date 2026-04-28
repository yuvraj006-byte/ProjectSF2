from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.player_service import (
    get_players as fetch_players,
    get_player_by_id as fetch_player_by_id
)

player_bp = Blueprint("player", __name__)


@player_bp.route("/players", methods=["GET"])
def get_players():
    conn = None
    try:
        conn = db_conn()
        data = fetch_players(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()


@player_bp.route("/players/<int:player_id>", methods=["GET"])
def get_player(player_id):
    conn = None
    try:
        conn = db_conn()
        data = fetch_player_by_id(conn, player_id)
        return jsonify(data)
    finally:
        if conn:
            conn.close()