def get_players(conn):
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM characters")
    results = cursor.fetchall()
    cursor.close()

    players = []

    for p in results:
        players.append({
            "id": p[0],
            "name": p[2],
            "level": p[3],
            "xp": p[4],
            "gold": p[5],
            "hp": p[6],
            "max_hp": p[7],
            "attack": p[8],
            "defense": p[9],
            "location_id": p[10]
        })

    return players

def get_player_by_id(conn, player_id):
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM characters WHERE id = %s;", (player_id,))
    result = cursor.fetchone()
    cursor.close()

    if result:
        return {
            "id": result[0],
            "name": result[2],
            "level": result[3],
            "xp": result[4],
            "gold": result[5],
            "hp": result[6],
            "max_hp": result[7],
            "attack": result[8],
            "defense": result[9],
            "location_id": result[10]
        }
    else:
        return {"error": "Player not found"}