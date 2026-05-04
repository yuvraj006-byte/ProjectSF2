from flask import Blueprint, jsonify
from server.database.db import db_conn
from server.services.quest_service import (
    get_quests as fetch_quests,
    get_quest_by_id as fetch_quest_by_id
)

quest_bp = Blueprint("quest", __name__)


@quest_bp.route("/quests", methods=["GET"])
def get_quests():
    conn = None
    try:
        conn = db_conn()
        data = fetch_quests(conn)
        return jsonify(data)
    finally:
        if conn:
            conn.close()


@quest_bp.route("/quests/<int:quest_id>", methods=["GET"])
def get_quest_by_id(quest_id):
    conn = None
    try:
        conn = db_conn()
        data = fetch_quest_by_id(conn, quest_id)
        return jsonify(data)
    finally:
        if conn:
            conn.close()