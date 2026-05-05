def get_enemy_drops(conn):
    cursor = conn.cursor()

    sql = """
        SELECT ed.id, e.name, i.name, ed.drop_rate,
               ed.quantity_min, ed.quantity_max
        FROM enemy_drops ed
        JOIN enemies e ON ed.enemy_id = e.id
        JOIN items i ON ed.item_id = i.id;
    """

    cursor.execute(sql)
    results = cursor.fetchall()
    cursor.close()

    drops = []

    for d in results:
        drops.append({
            "id": d[0],
            "enemy_name": d[1],
            "item_name": d[2],
            "drop_rate": d[3],
            "quantity_min": d[4],
            "quantity_max": d[5]
        })

    return drops

def get_drops_by_enemy(conn, enemy_id):
    cursor = conn.cursor()

    sql = """
        SELECT ed.id, e.name, i.name, ed.drop_rate,
               ed.quantity_min, ed.quantity_max
        FROM enemy_drops ed
        JOIN enemies e ON ed.enemy_id = e.id
        JOIN items i ON ed.item_id = i.id
        WHERE ed.enemy_id = %s;
    """

    cursor.execute(sql, (enemy_id,))
    results = cursor.fetchall()
    cursor.close()

    drops = []

    for d in results:
        drops.append({
            "id": d[0],
            "enemy_name": d[1],
            "item_name": d[2],
            "drop_rate": d[3],
            "quantity_min": d[4],
            "quantity_max": d[5]
        })

    return drops