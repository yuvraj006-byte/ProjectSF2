from flask import Blueprint, request, jsonify, render_template
from server.database.db import db_conn

from server.services.save_service import create_game_save, get_user_saves
from server.services.character_service import create_character


game_bp = Blueprint("game", __name__)


@game_bp.route("/start", methods=["POST"])
def start_game():
    conn = None
    try:
        data = request.json

        user_id = data["user_id"]
        name = data["name"]

        conn = db_conn()

        #  1. Check existing saves
        saves = get_user_saves(conn, user_id)

        if isinstance(saves, dict) and "error" in saves:
            return jsonify(saves), 400

        if saves:
            #  LOAD EXISTING SAVE
            latest_save = saves[0]

            return jsonify({
                "save_id": latest_save["id"],
                "message": "loaded_existing_save"
            })

        #  2. Create new save
        save = create_game_save(conn, user_id, f"{name}'s Save")
        if "error" in save:
            return jsonify(save), 400

        save_id = save["save_id"]

        #  3. Create character
        character = create_character(conn, save_id, name)
        if "error" in character:
            return jsonify(character), 400

        return jsonify({
            "save_id": save_id,
            "character": character,
            "message": "new_game_created"
        })

    finally:
        if conn:
            conn.close()


@game_bp.route("/you-died", methods=["GET"])
def you_died():
    try:
        return render_template("/GameOver/dead.html")
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@game_bp.route("/you-won", methods=["GET"])
def you_won():
    try:
        return render_template("/GameOver/won.html")
    except Exception as e:
        return jsonify({"error": str(e)}), 500
