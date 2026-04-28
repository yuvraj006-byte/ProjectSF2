def get_shops(conn):
    cursor = conn.cursor()

    sql = "SELECT * FROM shops;"
    cursor.execute(sql)

    results = cursor.fetchall()
    cursor.close()

    shops = []

    for s in results:
        shops.append({
            "id": s[0],
            "region_id": s[1],
            "name": s[2]
        })

    return shops

def get_shops_by_location(conn, location_id):
    cursor = conn.cursor()

    sql = "SELECT * FROM shops WHERE region_id = %s;"
    cursor.execute(sql, (location_id,))

    results = cursor.fetchall()
    cursor.close()

    shops = []

    for s in results:
        shops.append({
            "id": s[0],
            "region_id": s[1],
            "name": s[2]
        })

    return shops