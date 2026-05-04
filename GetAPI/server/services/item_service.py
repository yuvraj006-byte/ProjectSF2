def get_items(conn):
    cursor = conn.cursor()

    sql = "SELECT * FROM items;"
    cursor.execute(sql)

    results = cursor.fetchall()
    cursor.close()

    items = []

    for i in results:
        items.append({
            "id": i[0],
            "name": i[1],
            "description": i[2],
            "item_type": i[3],
            "attack_bonus": i[4],
            "defense_bonus": i[5],
            "hp_restore": i[6],
            "price": i[7],
            "from_quests": i[8]
        })

    return items

def get_items_by_type(conn, item_type):
    cursor = conn.cursor()

    sql = "SELECT * FROM items WHERE item_type = %s;"
    cursor.execute(sql, (item_type,))

    results = cursor.fetchall()
    cursor.close()

    items = []

    for i in results:
        items.append({
            "id": i[0],
            "name": i[1],
            "description": i[2],
            "item_type": i[3],
            "attack_bonus": i[4],
            "defense_bonus": i[5],
            "hp_restore": i[6],
            "price": i[7],
            "from_quests": i[8]
        })

    return items