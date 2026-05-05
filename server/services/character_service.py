def create_character(conn, save_id, name, current_location_id):

    cursor = None
    try:
        cursor = conn.cursor()

        query = """
    INSERT INTO characters (
        save_id,
        name,
        level,
        gold,
        hp,
        max_hp,
        attack,
        defense,
        current_location_id
    )
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

        params = (
            save_id,
            name,
            1,
            100,
            100,
            100,
            10,
            5,
            current_location_id
        )

        cursor.execute(query, params)
        conn.commit()

        return {
            "character_id": cursor.lastrowid,
            "name": name
        }

    except Exception as e:
        print("SQL ERROR:", str(e))
        return {"error": str(e)}

    finally:
        if cursor:
            cursor.close()


def get_player(conn, charId):
    print("GIVING CHARACTER STATS")
    cursor = None
    try:
        cursor = conn.cursor()

        cursor.execute("""
            SELECT id, name, hp, max_hp, attack, defense, level, current_location_id
            FROM characters
            WHERE id = %s
        """, (charId,))

        row = cursor.fetchone()

        if not row:
            return {"error": "character_not_found"}

        return {
            "id": row[0],
            "name": row[1],
            "hp": row[2],
            "max_hp": row[3],
            "attack": row[4],
            "defense": row[5],
            "level": row[6],
            "location_id": row[7]
        }

    except Exception as e:
        return {"error": str(e)}

    finally:
        if cursor:
            cursor.close()


def update_player_hp(conn, save_id, new_hp):
    cursor = None
    try:
        cursor = conn.cursor()

        cursor.execute("""
            UPDATE characters
            SET hp = %s
            WHERE save_id = %s
        """, (new_hp, save_id))

        conn.commit()

        return {"success": True}

    except Exception as e:
        return {"error": str(e)}

    finally:
        if cursor:
            cursor.close()


def update_location(conn, location_id, save_id, name):
    cursor = None
    try:
        cursor = conn.cursor()

        cursor.execute("""
            UPDATE characters
            SET current_location_id = %s
            WHERE save_id = %s AND name = %s
        """, (location_id, save_id, name))

        conn.commit()

        return {"success": True}

    except Exception as e:
        return {"error": str(e)}

    finally:
        if cursor:
            cursor.close()
