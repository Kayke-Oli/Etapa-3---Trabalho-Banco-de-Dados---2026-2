from database import connect_to_database
from criar_tabelas import criar_tabela_usuarios
from usuarios import listar_usuarios

def main():
    connection = connect_to_database()

    if connection:
        try:
            criar_tabela_usuarios(connection)
            listar_usuarios(connection)

        finally:
            connection.close()

if __name__ == "__main__":
    main()
