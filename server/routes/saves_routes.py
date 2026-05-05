from flask import Blueprint, request, jsonify, render_template
from server.database.db import db_conn
from server.services.save_service import (
    create_game_save,
    get_user_saves
)

saves_bp = Blueprint("saves", __name__)


@saves_bp.route("/saves-page")
def saves_page():
    try:
        return render_template("/GameSaves/index.html")
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@saves_bp.route("/create", methods=["POST"])
def create_save_route():
    conn = None
    try:
        data = request.get_json()

        if not data:
            return jsonify({"error": "No input data"}), 400
        user_id = data.get("user_id")
        save_name = data.get("save_name", "New Save")

        if not user_id:
            return jsonify({"error": "Missing user_id"}), 400

        conn = db_conn()

        result = create_game_save(conn, user_id, save_name)

        if "error" in result:
            return jsonify(result), 400

        return jsonify(result)

    finally:
        if conn:
            conn.close()


@saves_bp.route("/user/<int:user_id>", methods=["GET"])
def get_saves(user_id):
    conn = None
    try:
        conn = db_conn()

        result = get_user_saves(conn, user_id)

        if isinstance(result, dict) and "error" in result:
            return jsonify(result), 400

        return jsonify(result)

    finally:
        if conn:
            conn.close()
