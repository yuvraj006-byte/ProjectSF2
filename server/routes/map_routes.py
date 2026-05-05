from flask import Blueprint, render_template, jsonify

map_bp = Blueprint("map", __name__)


@map_bp.route("/map", methods=['GET'])
def getMaps():
    try:
        return render_template("/Map/index.html")
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@map_bp.route("/Mustafar")
def mustafar():
    return render_template("/Map/index.html", empire="mustafar")


@map_bp.route("/Kamino")
def kamino():
    return render_template("/Map/index.html", empire="kamino")


@map_bp.route("/Genosis")
def genosis():
    return render_template("/Map/index.html", empire="genosis")


@map_bp.route("/Nepotis")
def nepotis():
    return render_template("/Map/index.html", empire="nepotis")
