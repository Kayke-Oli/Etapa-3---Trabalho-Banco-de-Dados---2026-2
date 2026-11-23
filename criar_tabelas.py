def criar_tabela_usuarios(connection):
    cursor = None

    try:
        cursor = connection.cursor()

        sql = """
        CREATE TABLE IF NOT EXISTS usuarios (
            id INT AUTO_INCREMENT PRIMARY KEY,
            nome VARCHAR(100) NOT NULL,
            email VARCHAR(150) NOT NULL UNIQUE,
            senha VARCHAR(255) NOT NULL
        )
        """

        cursor.execute(sql)
        connection.commit()

        print("Tabela usuarios criada com sucesso!")

    except Exception as e:
        connection.rollback()
        print(f"Erro ao criar tabela: {e}")

    finally:
        if cursor:
            cursor.close()
