def get_stables(conn):
    cursor = conn.cursor()

    sql = "SELECT * FROM stables;"
    cursor.execute(sql)

    results = cursor.fetchall()
    cursor.close()

    stables = []

    for s in results:
        stables.append({
            "id": s[0],
            "location_id": s[1],
            "name": s[2]
        })

    return stables

def get_stables_by_location(conn, location_id):
    cursor = conn.cursor()

    sql = "SELECT * FROM stables WHERE location_id = %s;"
    cursor.execute(sql, (location_id,))

    results = cursor.fetchall()
    cursor.close()

    stables = []

    for s in results:
        stables.append({
            "id": s[0],
            "location_id": s[1],
            "name": s[2]
        })

    return stables