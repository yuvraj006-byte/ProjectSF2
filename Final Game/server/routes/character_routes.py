from server.services.location_service import get_empire, get_random_nation_by_empire
from server.services.character_service import create_character, get_player, update_location
from server.database.db import db_conn
from flask import Blueprint, request, jsonify, render_template
print("🔥 CHARACTER ROUTES LOADED")


characters_bp = Blueprint("characters", __name__, url_prefix="/characters")


@characters_bp.route("/create-page")
def create_page():
    try:
        return render_template("/Character/index.html")
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@characters_bp.route("/create", methods=["POST"])
def create_character_route():
    conn = None
    try:
        data = request.json

        if not data:
            return jsonify({"error": "No JSON received"}), 400

        save_id = data.get("save_id")
        name = data.get("character_name")
        empire = data.get("empire")

        if not save_id or not name or not empire:
            return jsonify({"error": "Missing required fields"}), 400

        conn = db_conn()

        #  Empire lookup
        empire_result = get_empire(conn, empire)

        if "error" in empire_result:
            return jsonify(empire_result), 400

        empire_id = empire_result["id"]

        #  Nation lookup
        nation_result = get_random_nation_by_empire(conn, empire_id)

        if "error" in nation_result:
            return jsonify(nation_result), 400

        nation_id = nation_result["id"]

        result = create_character(
            conn,
            save_id,
            name,
            nation_id
        )

        if "error" in result:
            return jsonify(result), 400

        return jsonify(result)

    except Exception as e:

        return jsonify({"error": str(e)}), 500

    finally:
        if conn:
            conn.close()


@characters_bp.route("/player/<character_id>", methods=["GET"])
def get_player_route(character_id):
    conn = None
    try:
        conn = db_conn()

        result = get_player(conn, character_id)

        if "error" in result:
            return jsonify(result), 404

        return jsonify(result)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        if conn:
            conn.close()


@characters_bp.route("/update-location", methods=["POST"])
def update_location_route():
    conn = None
    try:
        conn = db_conn()
        data = request.get_json()

        location_id = data.get("location_id")
        save_id = data.get("save_id")
        name = data.get("name")

        if not location_id or not save_id or not name:
            return jsonify({
                "success": False,
                "error": "Missing required fields"
            }), 400

        result = update_location(conn, location_id, save_id, name)

        if "error" in result:
            return jsonify(result), 500

        return jsonify(result), 200

    except Exception as e:
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500

    finally:
        if conn:
            conn.close()
