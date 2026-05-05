def get_mounts(conn):
    cursor = conn.cursor()

    sql = "SELECT * FROM mounts;"
    cursor.execute(sql)

    results = cursor.fetchall()
    cursor.close()

    mounts = []

    for m in results:
        mounts.append({
            "id": m[0],
            "name": m[1],
            "speed": m[2],
            "description": m[3]
        })

    return mounts