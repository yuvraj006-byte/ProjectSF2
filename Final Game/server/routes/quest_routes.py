# quests/routes.py
from flask import Blueprint, jsonify, request
from server.database.db import db_conn

quest_bp = Blueprint("quest_bp", __name__)

# Get quests filtered by location


@quest_bp.route("/quests/<int:location_id>")
def get_quests(location_id):
    conn = db_conn()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, title, location_id
        FROM quests
        WHERE location_id = %s
    """, (location_id,))

    results = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify([
        {"id": q[0], "title": q[1]}
        for q in results
    ])


# Get single quest
@quest_bp.route("/quest/<int:quest_id>")
def get_quest(quest_id):
    conn = db_conn()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, title, question
        FROM quests
        WHERE id = %s
    """, (quest_id,))

    q = cursor.fetchone()

    cursor.close()
    conn.close()

    if q:
        return jsonify({
            "id": q[0],
            "title": q[1],
            "question": q[2]
        })

    return jsonify({"error": "Not found"}), 404


# Submit answer (no XP now)
@quest_bp.route("/submit", methods=["POST"])
def submit():
    data = request.json
    quest_id = data.get("quest_id")
    user_answer = data.get("answer", "").strip().lower()

    conn = db_conn()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT answer
        FROM quests
        WHERE id = %s
    """, (quest_id,))

    result = cursor.fetchone()

    cursor.close()
    conn.close()

    if not result:
        return jsonify({"result": "Quest not found", "correct": False})

    correct_answer = result[0].strip().lower()

    if user_answer == correct_answer:
        return jsonify({
            "result": "Correct!",
            "correct": True
        })
    else:
        return jsonify({
            "result": "Wrong answer!",
            "correct": False
        })
