def equip_item(conn, character_id, item_id, slot):
    cursor = conn.cursor()

    sql = """
        SELECT quantity FROM inventory
        WHERE character_id = %s AND item_id = %s;
    """
    cursor.execute(sql, (character_id, item_id))
    result = cursor.fetchone()

    if not result:
        cursor.close()
        return {"error": "Item not in inventory"}

    sql = """
        DELETE FROM equipment
        WHERE character_id = %s AND slot = %s;
    """
    cursor.execute(sql, (character_id, slot))

    sql = """
        INSERT INTO equipment (character_id, item_id, slot)
        VALUES (%s, %s, %s);
    """
    cursor.execute(sql, (character_id, item_id, slot))

    conn.commit()
    cursor.close()

    return {"message": "Item equipped successfully"}