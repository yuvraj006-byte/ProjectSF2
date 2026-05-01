from flask import Flask, send_from_directory
from server.routes.location_routes import location_bp
from server.routes.enemy_routes import enemy_bp
from server.routes.item_routes import item_bp
from server.routes.mount_routes import mount_bp
from server.routes.stable_routes import stable_bp
from server.routes.shop_routes import shop_bp
from server.routes.enemy_drop_routes import enemy_drop_bp
from server.routes.player_routes import player_bp
from server.routes.quest_routes import quest_bp
from server.routes.score_routes import score_bp
from server.routes.equipment_routes import equipment_bp

app = Flask(
    __name__,
    static_folder="../client",
)


@app.route("/")
def index():
    return send_from_directory(app.static_folder, "index.html")

# register location blueprint
app.register_blueprint(location_bp, url_prefix="/location")
app.register_blueprint(enemy_bp)
app.register_blueprint(item_bp)
app.register_blueprint(mount_bp)
app.register_blueprint(stable_bp)
app.register_blueprint(shop_bp)
app.register_blueprint(enemy_drop_bp)
app.register_blueprint(player_bp)
app.register_blueprint(quest_bp)
app.register_blueprint(score_bp)
app.register_blueprint(equipment_bp)

