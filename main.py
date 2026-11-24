import sqlparse
from database import conectar


def executar_script(conexao, caminho):
    cursor = conexao.cursor()

    try:
        with open(caminho, "r", encoding="utf-8") as arquivo:
            script = arquivo.read()

        comandos = sqlparse.split(script)

        for comando in comandos:
            if comando.strip():
                cursor.execute(comando)

                if cursor.description:
                    colunas = [coluna[0] for coluna in cursor.description]
                    resultados = cursor.fetchall()

                    print("\n", colunas)

                    for linha in resultados:
                        print(linha)

        conexao.commit()
        print(f"\nScript executado: {caminho}")

    except Exception as erro:
        conexao.rollback()
        print(f"Erro ao executar script: {erro}")

    finally:
        cursor.close()


def main():
    conexao = conectar()

    if conexao is None:
        return

    try:
        executar_script(conexao, "sql/criar_banco.sql")
        executar_script(conexao, "sql/povoar_banco.sql")
        executar_script(conexao, "sql/consultas.sql")

    finally:
        conexao.close()


if __name__ == "__main__":
    main()