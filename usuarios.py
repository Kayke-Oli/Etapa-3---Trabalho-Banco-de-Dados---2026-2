
def listar_usuarios(connection):
    cursor = None

    try:
        cursor = connection.cursor()

        cursor.execute("SELECT * FROM usuarios")

        usuarios = cursor.fetchall()

        for usuario in usuarios:
            print(usuario)

    except Exception as e:
        print(f"Erro ao listar usuários: {e}")

    finally:
        if cursor:
            cursor.close()


def buscar_usuario(connection, id_usuario):
    cursor = None

    try:
        cursor = connection.cursor()

        cursor.execute(
            "SELECT * FROM usuarios WHERE id = %s",
            (id_usuario,)
        )

        usuario = cursor.fetchone()

        return usuario

    except Exception as e:
        print(f"Erro ao buscar usuário: {e}")
        return None

    finally:
        if cursor:
            cursor.close()