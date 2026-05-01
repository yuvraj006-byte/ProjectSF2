from flask import Blueprint, request, jsonify
from server.database.db import db_conn
from server.services.equipment_service import equip_item as equip_item_service

equipment_bp = Blueprint("equipment", __name__)


@equipment_bp.route("/characters/<int:character_id>/equip", methods=["POST"])
def equip_item(character_id):
    conn = None
    try:
        data = request.get_json()

        item_id = data.get("item_id")
        slot = data.get("slot")

        if not item_id or not slot:
            return jsonify({"error": "item_id and slot required"}), 400

        conn = db_conn()
        result = equip_item_service(conn, character_id, item_id, slot)

        return jsonify(result)

    finally:
        if conn:
            conn.close()