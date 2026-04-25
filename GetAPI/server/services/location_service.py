def get_empire(conn):
    cursor = conn.cursor()

    sql = """
        SELECT * FROM empires
        ORDER BY RAND()
        LIMIT 1;"""

    cursor.execute(sql,)

    result = cursor.fetchone()
    cursor.close()

    if result:
        return {
            "id": result[0],
            "name": result[1],
            "info": result[2]
        }
    else:
        return {"error": "No Empire Found!"}


def get_nation(conn):
    cursor = conn.cursor()

    sql = """
        SELECT * FROM nations
        ORDER BY RAND()
        LIMIT 1;"""

    cursor.execute(sql)

    result = cursor.fetchone()
    cursor.close()

    if result:
        return {
            "id": result[0],
            "name": result[1],
            "region": result[3],
            "info": result[4]
        }
    else:
        return {"error": "No Nation Found!"}


def get_nations_by_empire(conn, empire_id):
    cursor = conn.cursor()

    sql = """
        SELECT * FROM nations
        WHERE empire_id = %s;
    """
    cursor.execute(sql, (empire_id,))
    nations = cursor.fetchall()

    cursor.close()

    nations_list = []
    for n in nations:
        nations_list.append({
            "id": n[0],
            "name": n[1],
            "region": n[3],
            "info": n[4]
        })

    return {
        "empire_id": empire_id,
        "nations": nations_list
    }
