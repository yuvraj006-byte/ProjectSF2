def get_empire(conn, name):
    cursor = conn.cursor()
    sql = "SELECT *  FROM empires WHERE LOWER(name) = LOWER(%s)"
    cursor.execute(sql, (name,))
    result = cursor.fetchone()
    cursor.close()

    if result is None:  # <--- crucial check
        return {"error": "No Empire Found!"}

    return {
        "id": result[0],
        "name": result[1],
        "info": result[2]
    }


def get_nation_by_empire(conn, empire_name, nation_name):
    cursor = conn.cursor()

    sql1 = "SELECT id FROM empires WHERE LOWER(name) = LOWER(%s)"
    cursor.execute(sql1, (empire_name,))
    empire_row = cursor.fetchone()

    if empire_row is None:
        cursor.close()
        return {"error": "No Empire Found!"}

    empire_id = empire_row[0]

    sql2 = "SELECT * FROM nations WHERE empire_id = %s AND name = %s"
    cursor.execute(sql2, (empire_id, nation_name))
    nation = cursor.fetchone()

    cursor.close()

    if nation is None:
        return {"error": "Nation not found under this empire!"}

    return {
        "id": nation[0],
        "name": nation[1],
        "info": nation[4]
    }


def get_random_nation_by_empire(conn, empire_id):
    cursor = conn.cursor()

    sql = "SELECT id FROM nations WHERE empire_id = %s ORDER BY RAND() LIMIT 1"

    cursor.execute(sql, (empire_id,))
    nation_id = cursor.fetchone()

    cursor.close()

    if nation_id is None:
        return {"error": "Nation not found under this empire!"}
    return {
        "id": nation_id[0]
    }
