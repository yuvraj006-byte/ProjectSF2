from flask import Flask, jsonify, request
from database.db import db_conn

app = Flask(__name__, static_folder="client", static_url_path="")

@app.route("/")
def home():
    return app.send_static_file("quests.html")


@app.route("/quests")
def get_quests():
    conn = db_conn()
    cursor = conn.cursor()

    cursor.execute("SELECT id, title FROM quests")
    results = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify([
        {"id": q[0], "title": q[1]}
        for q in results
    ])


@app.route("/quest/<int:quest_id>")
def get_quest(quest_id):
    conn = db_conn()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, title, description, xp_reward
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
            "question": q[2],
            "xp": q[3]
        })

    return jsonify({"error": "Not found"}), 404


@app.route("/submit", methods=["POST"])
def submit():
    return jsonify({
        "result": "Submitted!",
        "xp": 10
    })
