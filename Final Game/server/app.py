from flask import Flask, render_template

from .routes.map_routes import map_bp
from .routes.backGround_routes import backGround_bp
from .routes.auth_routes import auth_bp
from .routes.auth_pages_routes import authPages_bp
from .routes.saves_routes import saves_bp
from .routes.game_routes import game_bp
from .routes.character_routes import characters_bp
from .routes.quest_routes import quest_bp

app = Flask(
    __name__,
    static_folder="../client/static",
    static_url_path="/static",
    template_folder="../client/templates"
)

# Main page


@app.route("/")
def index():
    return render_template("index.html")


# Register blueprints (clean + scalable structure)
app.register_blueprint(map_bp)
app.register_blueprint(backGround_bp)
app.register_blueprint(auth_bp, url_prefix="/auth")
app.register_blueprint(authPages_bp)
app.register_blueprint(saves_bp, url_prefix="/saves")
app.register_blueprint(game_bp, url_prefix="/api/game")
app.register_blueprint(characters_bp)
app.register_blueprint(quest_bp)


if __name__ == "__main__":
    app.run(debug=True)
