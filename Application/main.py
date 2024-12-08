import psycopg2
from psycopg2 import sql
import re

#################################################
##SEÇÃO DE FUNÇÕES AUXILIARES####################

def validar_email(email):
    padrao = r'^[^@]+@[^@]+\.[^@]+$'
    return bool(re.match(padrao, email))
    
def validar_nome(nome):
    return nome.replace(" ", "").isalpha()

def validar_data(data):
    padrao = r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$'
    return bool(re.match(padrao, data))

def validar_data_hora(data_hora):
    padrao = r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]) (\d{2}):([0-5]\d):([0-5]\d)$'
    return bool(re.match(padrao, data_hora))

def validar_tipo_conta(tipo):
    opcoes_validas = {'comum', 'premium', 'admin'}
    return tipo in opcoes_validas

def validar_qualidades(tipo):
    opcoes_validas = {'380p', '480p', '720p', '1080p', '2K', '4K'}
    return tipo in opcoes_validas

def validar_inteiro_positivo(numero):
    padrao = r'^[1-9]\d*$'
    return bool(re.match(padrao, numero))


def buscar_maior_valor(self, tabela, atributo):
    query = sql.SQL("SELECT MAX({}) FROM {}").format(
        sql.Identifier(atributo),
        sql.Identifier(tabela)
    )
    result = self.db.execute_query(query, fetch=True)  # Garantir fetch=True
    if result and result[0][0] is not None:  # Verifica se há dados válidos
        return result[0][0]
    else:
        return 0  # Retorna 0 se a tabela estiver vazia ou se ocorrer um erro



#################################################
#BANCO DE DADOS##################################

class MultisportDB:
    def __init__(self, host, database, user, password, port):
        self.host = host
        self.database = database
        self.user = user
        self.password = password
        self.port = port
        self.conn = None

    def connect(self):
        try:
            self.conn = psycopg2.connect(
                host=self.host,
                database=self.database,
                user=self.user,
                password=self.password,
                port=self.port
            )
            print("Conexão com o banco de dados estabelecida com sucesso!")
        except psycopg2.Error as e:
            print(f"Erro ao conectar ao banco de dados: {e}")
            exit()

    def close(self):
        if self.conn:
            self.conn.close()
            print("Conexão com o banco de dados encerrada.")

    def execute_query(self, query, params=None, fetch=False):
        try:
            with self.conn.cursor() as cur:
                cur.execute(query, params)
                if fetch:
                    return cur.fetchall()  # Retorna os dados da consulta
                self.conn.commit()  # Confirma alterações para consultas de modificação
                return 1
        except psycopg2.Error as e:
            print(f"Erro ao executar query: {e}")
            self.conn.rollback()  # Reverte a transação em caso de erro
            return None  # Retorna explicitamente None em caso de erro

#################################################
#APLICAÇÃO#######################################
class MultisportApp:
    def __init__(self, db):
        self.db = db

    def cadastrar_usuario(self):
        print("\nCadastro de Usuário:")
        inputString = -1
        print("A qualquer momento, digite '0' para cancelar.")

        inputString = input("Digite o e-mail: ")
        while (not validar_email(inputString) and inputString!='0'):
            print("Email precisa estar no formato 'exemplo@dominio.com' ou similares.")
            inputString = input("Digite o e-mail novamente: ")
        if inputString == '0':
            return 0
        email = inputString

        inputString = input("Digite o nome: ")
        while (not validar_nome(inputString) and inputString !='0'):
            print("O nome só pode conter letras.")
            inputString = input("Digite o nome novamente: ")
        if inputString == '0':
            return 0
        nome = inputString

        inputString = input("Digite a data de nascimento (YYYY-MM-DD): ")
        while (not validar_data(inputString) and inputString !='0'):
            print("A data precisa estar no formato YYYY-MM-DD")
            inputString = input("Digite a data de nascimento novamente: ")
        if inputString == '0':
            return 0
        data_nascimento = inputString

        inputString = input("Digite o tipo de conta (comum/premium/admin): ")
        while (not validar_tipo_conta(inputString) and inputString !='0'):
            print("O tipo da conta só pode ser 'comum', 'premium' ou 'admin'")
            inputString = input("Digite o tipo de conta novamente: ")
        if inputString == '0':
            return 0
        tipo_conta = inputString

        query = """
        INSERT INTO Usuario (email, nome, data_nascimento, tipo_conta)
        VALUES (%s, %s, %s, %s);
        """
        params = (email, nome, data_nascimento, tipo_conta)
        if self.db.execute_query(query, params) != None:
            print("Usuário cadastrado com sucesso!")
        

    def cadastrar_transmissao(self):
        print("\nCadastro de Transmissão:")
        inputString = -1
        print("A qualquer momento, digite '0' para cancelar.")

        numero_transmissao = buscar_maior_valor(self, "transmissao", "numero_transmissao") + 1

        inputString = input("Digite o horário de início (YYYY-MM-DD HH:MM:SS): ")
        while (not validar_data_hora(inputString) and inputString != '0'):
            print("Data-Hora precisa estar no formato YYYY-MM-DD HH:MM:SS.")
            inputString = input("Digite o horário de início novamente: ")
        if inputString == '0':
            return 0
        horario_inicio = inputString

        inputString = input("Digite a duração em minutos: ")
        while (not validar_inteiro_positivo(inputString) and inputString != '0'):
            inputString = input("Digite um numero inteiro positivo: ")
        if inputString == '0':
            return 0
        duracao = inputString


        inputString = input("Digite a qualidade (ex.: 720p, 1080p, 4K): ")
        while (not validar_qualidades(inputString) and inputString != '0'):
            print("Qualidade inválida.")
            inputString = input("Digite a qualidade novamente: ")
        if inputString == '0':
            return 0
        qualidade = inputString

        nome_esporte = input("Digite o nome do esporte: ")
        nome_evento = input("Digite o nome do evento: ")


        inputString = input("Digite o horário do evento (YYYY-MM-DD HH:MM:SS): ")
        while (not validar_data_hora(inputString) and inputString != '0'):
            print("Data-Hora precisa estar no formato YYYY-MM-DD HH:MM:SS.")
            inputString = input("Digite o horário do evento novamente: ")
        if inputString == '0':
            return 0
        horario_evento = inputString

        query = """
        INSERT INTO Transmissao (numero_transmissao, horario_inicio, duracao, qualidade, nome_esporte, nome_evento, horario_evento)
        VALUES (%s, %s, %s, %s, %s, %s, %s);
        """
        params = (numero_transmissao, horario_inicio, duracao, qualidade, nome_esporte, nome_evento, horario_evento)
        if self.db.execute_query(query, params) != None:
            print("Transmissão cadastrada com sucesso!")
        

    def login_usuario(self):
        print("\nLogin de Usuário:")
        email = input("Digite o e-mail: ")
        query = """
        SELECT nome, tipo_conta FROM Usuario WHERE email = %s;
        """
        params = (email,)
        result = self.db.execute_query(query, params, fetch=True)
        if result:
            nome, tipo_conta = result[0]
            print(f"Bem-vindo, {nome}! Sua conta é do tipo: {tipo_conta}.")
        else:
            print("Usuário não encontrado. Verifique o e-mail informado.")

    def consultar_transmissoes_por_esporte(self):
        print("\nConsulta de Transmissões por Esporte:")
        esporte = input("Digite o nome do esporte: ")

        query = """
        SELECT numero_transmissao, horario_inicio, duracao, qualidade
        FROM Transmissao
        WHERE nome_esporte = %s;
        """
        params = (esporte,)
        results = self.db.execute_query(query, params, fetch=True)
        if results:
            print("\nTransmissões encontradas:")
            for t in results:
                print(f"Transmissão: {t[0]}, Início: {t[1]}, Duração: {t[2]} min, Qualidade: {t[3]}")
        else:
            print("Nenhuma transmissão encontrada para o esporte informado.")

    def consultar_atletas_por_time(self):
        print("\nConsulta de Atletas por Time:")
        time = input("Digite o nome do time: ")

        query = """
        SELECT * 
        FROM atleta
        WHERE nome_time = %s;
        """
        params = (time,)
        results = self.db.execute_query(query, params, fetch=True)
        if results:
            print("\nAtletas encontrados:")
            for t in results:
                print(f"CPF: {t[0]}, Nome: {t[2]}, Idade: {t[3]}")
        else:
            print("Nenhum atleta encontrado para o time informado.")


    def menu(self):
        while True:
            print("\nMenu Principal:")
            print("1. Login de Usuário")
            print("2. Cadastrar Usuário")
            print("3. Cadastrar Transmissão")
            print("4. Consultar Transmissões por Esporte")
            print("5. Selecionar atletas de um time")
            print("6. Sair")
            opcao = input("Escolha uma opção: ")

            if opcao == "1":
                self.login_usuario()
            elif opcao == "2":
                self.cadastrar_usuario()
            elif opcao == "3":
                self.cadastrar_transmissao()
            elif opcao == "4":
                self.consultar_transmissoes_por_esporte()
            elif opcao == "5":
                self.consultar_atletas_por_time()
            elif opcao == "6":
                print("Encerrando aplicação...")
                break
            else:
                print("Opção inválida! Tente novamente.")


if __name__ == "__main__":
    # Configurações do banco de dados
    db_config = {
        "host": "localhost",
        "database": "multisport",
        "user": "postgres",
        "password": "SENHA", ##sua senha do postgres
        "port": "5432" ##a porta que está configurada no seu banco
    }

    # Instância do banco e conexão
    db = MultisportDB(**db_config)
    db.connect()

    # Instância da aplicação e menu principal
    app = MultisportApp(db)
    try:
        app.menu()
    finally:
        db.close()
