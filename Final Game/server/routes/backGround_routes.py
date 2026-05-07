from flask import Blueprint, render_template, jsonify, url_for
from server.database.db import db_conn
from server.services.location_service import get_nation_by_empire

backGround_bp = Blueprint("background", __name__)

# ===============================
# PAGE ROUTE
# ===============================


@backGround_bp.route("/<empire>/<nation>")
def background_page(empire, nation):
    conn = None
    data = None
    try:
        conn = db_conn()
        data = get_nation_by_empire(conn, empire, nation)

        if "error" in data:
            return jsonify(data), 404

        if empire in ["Kamino", "Genosis", "Nepotis", "Mustafar"]:
            return render_template(
                "BackGround/index.html",
                nation=data,
                empire=empire
            )

        return jsonify({"error": "Empire not supported"}), 404

    finally:
        if conn:
            conn.close()


# BACKGROUND IMAGES

@backGround_bp.route("/api/background/<empire>")
def get_background_layers(empire):
    backgrounds = {
        "kamino": [
            url_for("static", filename="images/backGroundImages/kaminoBG/sky.png"),
            url_for("static", filename="images/backGroundImages/kaminoBG/fog.png"),
            url_for(
                "static", filename="images/backGroundImages/kaminoBG/3_ice_castle.png"),
            url_for("static", filename="images/backGroundImages/kaminoBG/snow.png"),
            url_for("static", filename="images/backGroundImages/kaminoBG/snow_2.png"),
            url_for(
                "static", filename="images/backGroundImages/kaminoBG/1_foreground_mts.png"),
            url_for(
                "static", filename="images/backGroundImages/kaminoBG/2_foreground_mts.png"),
        ],

        "genosis": [
            url_for(
                "static", filename="images/backGroundImages/genosisBG/1.png"),
            url_for("static", filename="images/backGroundImages/genosisBG/2.png"),
            url_for("static", filename="images/backGroundImages/genosisBG/3.png"),
            url_for("static", filename="images/backGroundImages/genosisBG/4.png"),
            url_for("static", filename="images/backGroundImages/genosisBG/5.png"),
        ],
        "nepotis": [
            url_for("static", filename="images/backGroundImages/nepotisBG/1.png"),
            url_for("static", filename="images/backGroundImages/nepotisBG/2.png"),
            url_for("static", filename="images/backGroundImages/nepotisBG/3.png"),
            url_for("static", filename="images/backGroundImages/nepotisBG/4.png"),
            url_for("static", filename="images/backGroundImages/nepotisBG/5.png"),
            url_for("static", filename="images/backGroundImages/nepotisBG/6.png"),
            url_for("static", filename="images/backGroundImages/nepotisBG/7.png"),

        ],
        "mustafar": [
            url_for(
                "static", filename="images/backGroundImages/mustafarBG/1.png"),
            url_for("static", filename="images/backGroundImages/mustafarBG/3.png"),
            url_for("static", filename="images/backGroundImages/mustafarBG/5.png"),
            url_for(
                "static", filename="images/backGroundImages/mustafarBG/4.png"),
            url_for("static", filename="images/backGroundImages/mustafarBG/2.png"),
            url_for("static", filename="images/backGroundImages/mustafarBG/6.png"),

        ]
    }

    if empire not in backgrounds:
        return jsonify({"error": "Background not found"}), 404

    return jsonify(backgrounds[empire])
