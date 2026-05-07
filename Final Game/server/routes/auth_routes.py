from flask import Blueprint, request, jsonify
from server.database.db import db_conn
from server.services.auth_service import get_user_by_username
import bcrypt

auth_bp = Blueprint("auth", __name__)


@auth_bp.route("/register", methods=["POST"])
def register():
    username = request.form.get("username")
    password = request.form.get("password")

    if not username or not password:
        return jsonify({"status": "error", "message": "Missing fields"}), 400

    try:
        conn = db_conn()
        cursor = conn.cursor()

        # 1. Check if user already exists
        check_query = "SELECT id FROM users WHERE user_name = %s"
        cursor.execute(check_query, (username,))
        existing_user = cursor.fetchone()

        if existing_user:
            cursor.close()
            conn.close()
            return jsonify({
                "status": "error",
                "message": "User already exists"
            }), 409  # 409 Conflict

        # 2. Hash password
        hashed_password = bcrypt.hashpw(
            password.encode("utf-8"),
            bcrypt.gensalt()
        )

        # 3. Insert new user
        insert_query = "INSERT INTO users (user_name, password) VALUES (%s, %s)"
        cursor.execute(insert_query, (username, hashed_password))

        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({"status": "success", "message": "User created"}), 201

    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500


@auth_bp.route("/login", methods=["POST"])
def login():
    username = request.form.get("username")
    password = request.form.get("password")

    if not username or not password:
        return jsonify({"status": "error", "message": "Missing fields"}), 400

    try:
        conn = db_conn()

        #  1. GET USER HERE
        user = get_user_by_username(conn, username)

        if not user:
            return jsonify({"status": "error", "message": "User not found"}), 404

        stored_hash = user["password"]
        user_id = user["id"]

        #  2. VERIFY PASSWORD
        if isinstance(stored_hash, str):
            stored_hash = stored_hash.encode("utf-8")
        elif isinstance(stored_hash, memoryview):
            stored_hash = stored_hash.tobytes()

        if not bcrypt.checkpw(password.encode("utf-8"), stored_hash):
            return jsonify({"status": "error", "message": "Invalid password"}), 401

        #  3. RETURN USER ID AFTER SUCCESS
        return jsonify({
            "status": "success",
            "message": "Login successful",
            "user_id": user_id
        }), 200

    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
