def get_enemies(conn):
    cursor = conn.cursor()

    sql = "SELECT * FROM enemies;"
    cursor.execute(sql)

    results = cursor.fetchall()
    cursor.close()

    enemies = []

    for e in results:
        enemies.append({
            "id": e[0],
            "name": e[1],
            "level": e[2],
            "location_id": e[3],
            "hp": e[4],
            "attack": e[5],
            "defense": e[6],
            "xp_reward": e[7],
            "gold_reward": e[8]
        })

    return enemies

def get_enemies_by_location(conn, location_id):
    cursor = conn.cursor()

    sql = "SELECT * FROM enemies WHERE location_id = %s;"
    cursor.execute(sql, (location_id,))

    results = cursor.fetchall()
    cursor.close()

    enemies = []

    for e in results:
        enemies.append({
            "id": e[0],
            "name": e[1],
            "level": e[2],
            "location_id": e[3],
            "hp": e[4],
            "attack": e[5],
            "defense": e[6],
            "xp_reward": e[7],
            "gold_reward": e[8]
        })

    return enemies
