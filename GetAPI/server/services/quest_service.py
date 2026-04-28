def get_quests(conn):
    cursor = conn.cursor()

    sql = "SELECT * FROM quests"
    cursor.execute(sql)

    results = cursor.fetchall()
    cursor.close()

    quests = []

    for q in results:
        quests.append({
            "id": q[0],
            "title": q[1],
            "description": q[2],
            "location_id": q[3],
            "xp_reward": q[4],
            "gold_reward": q[5]
        })

    return quests


def get_quest_by_id(conn, quest_id):
    cursor = conn.cursor()

    sql = "SELECT * FROM quests WHERE id = %s"
    cursor.execute(sql, (quest_id,))

    result = cursor.fetchone()
    cursor.close()

    if result:
        return {
            "id": result[0],
            "title": result[1],
            "description": result[2],
            "location_id": result[3],
            "xp_reward": result[4],
            "gold_reward": result[5]
        }
    else:
        return {"error": "Quest not found"}