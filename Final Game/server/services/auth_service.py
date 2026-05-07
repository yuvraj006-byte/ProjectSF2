def get_user_by_username(conn, user_name):
    cursor = None
    try:
        cursor = conn.cursor()

        cursor.execute("""
            SELECT id, password
            FROM users
            WHERE user_name = %s
        """, (user_name,))

        row = cursor.fetchone()

        if not row:
            return None  # cleaner than returning dict error here

        return {
            "id": row[0],
            "password": row[1]
        }

    except Exception as e:
        raise Exception(f"Database error: {str(e)}")

    finally:
        if cursor:
            cursor.close()
