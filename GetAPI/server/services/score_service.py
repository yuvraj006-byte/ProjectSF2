def get_character_score(conn, character_id):
    cursor = conn.cursor()

    sql = """
        SELECT name, level, xp, gold
        FROM characters
        WHERE id = %s;
    """

    cursor.execute(sql, (character_id,))
    result = cursor.fetchone()
    cursor.close()

    if result:
        return {
            "name": result[0],
            "level": result[1],
            "xp": result[2],
            "gold": result[3]
        }
    else:
        return {"error": "Character not found"}