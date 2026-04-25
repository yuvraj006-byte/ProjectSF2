from flask import Flask, send_from_directory
from server.routes.location_routes import location_bp

app = Flask(
    __name__,
    static_folder="../client",
)


@app.route("/")
def index():
    return send_from_directory(app.static_folder, "index.html")


# register location blueprint
app.register_blueprint(location_bp, url_prefix="/location")
