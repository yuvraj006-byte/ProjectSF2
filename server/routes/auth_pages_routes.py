from flask import Blueprint, render_template, jsonify


authPages_bp = Blueprint("authPages", __name__)


@authPages_bp.route("/register_page", methods=['GET'])
def register_page():
    try:
        return render_template("/Register/index.html")
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@authPages_bp.route("/login_page", methods=['GET'])
def login_page():
    try:
        return render_template("/Login/index.html")
    except Exception as e:
        return jsonify({"error": str(e)}), 500
