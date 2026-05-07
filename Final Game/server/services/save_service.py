def create_game_save(conn, user_id, save_name):
    cursor = None
    try:
        cursor = conn.cursor()

        cursor.execute("""
            INSERT INTO game_saves (user_id, save_name)
            VALUES (%s, %s)
        """, (user_id, save_name))

        conn.commit()

        return {
            "save_id": cursor.lastrowid,
            "save_name": save_name
        }

    except Exception as e:
        return {"error": str(e)}

    finally:
        if cursor:
            cursor.close()


def get_user_saves(conn, user_id):
    cursor = None
    try:
        cursor = conn.cursor()

        cursor.execute("""
            SELECT id, save_name, created_at
            FROM game_saves
            WHERE user_id = %s
            ORDER BY created_at DESC
        """, (user_id,))

        rows = cursor.fetchall()

        return [
            {
                "id": row[0],
                "save_name": row[1],
                "created_at": row[2]
            }
            for row in rows
        ]

    except Exception as e:
        return {"error": str(e)}

    finally:
        if cursor:
            cursor.close()
