CREATE TABLE Usuario (
    email VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(255),
    data_nascimento DATE,
    tipo_conta VARCHAR(50) NOT NULL,
    CHECK (tipo_conta IN ('comum', 'premium', 'admin'))
);

CREATE TABLE Esporte (
    nome_esporte VARCHAR(20) PRIMARY KEY,
    popularidade INT,
    categoria VARCHAR(20)
);

CREATE TABLE Localizacao (
    id_localizacao SERIAL PRIMARY KEY,
    cidade VARCHAR(50),
    estado VARCHAR(50),
    pais VARCHAR(50)
);

CREATE TABLE Instalacao_esportiva (
    nome_instalacao VARCHAR(50) PRIMARY KEY,
    id_localizacao INT NOT NULL,
    CONSTRAINT fk_instalacaoEsportiva FOREIGN KEY (id_localizacao) REFERENCES Localizacao(id_localizacao)
);

CREATE TABLE Evento_esportivo (
    nome_evento VARCHAR(50) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    nome_instalacao VARCHAR(50),
   	PRIMARY KEY (nome_evento, data_hora),
    CONSTRAINT fk_eventoEsportivo1 FOREIGN KEY (nome_instalacao) REFERENCES Instalacao_esportiva(nome_instalacao)
);

CREATE TABLE Transmissao (
    numero_transmissao SERIAL PRIMARY KEY,
    horario_inicio TIMESTAMP,
    duracao INT,
    qualidade VARCHAR(15),
    nome_esporte VARCHAR(20) NOT NULL,
    nome_evento VARCHAR(50) NOT NULL,
    horario_evento TIMESTAMP NOT NULL,
    CONSTRAINT fk_transmissao_esporte FOREIGN KEY (nome_esporte) REFERENCES Esporte(nome_esporte),
    CONSTRAINT fk_transmissao_evento FOREIGN KEY (nome_evento, horario_evento) REFERENCES Evento_esportivo(nome_evento, data_hora)
);

CREATE TABLE Anuncio (
    numero_anuncio SERIAL PRIMARY KEY,
    link_nuvem VARCHAR(255)
);

CREATE TABLE Transmissao_Usuario (
    numero_transmissao INT NOT NULL,
    email_usuario VARCHAR(255) NOT NULL,
    PRIMARY KEY (numero_transmissao, email_usuario),
    CONSTRAINT fk_transmissaoUsuario_usuario FOREIGN KEY (email_usuario) REFERENCES Usuario(email),
    CONSTRAINT fk_transmissaoUsuario_transmissao FOREIGN KEY (numero_transmissao) REFERENCES Transmissao(numero_transmissao)
);

CREATE TABLE User_transm_anuncio (
    numero_transmissao INT NOT NULL,
    email_usuario VARCHAR(255) NOT NULL,
    numero_anuncio INT NOT NULL,
    PRIMARY KEY (numero_transmissao, email_usuario, numero_anuncio),
    CONSTRAINT fk_userTransmAnuncio_transmissaoUsuario FOREIGN KEY (numero_transmissao, email_usuario) REFERENCES Transmissao_Usuario(numero_transmissao, email_usuario),
    CONSTRAINT fk_userTransmAnuncio_anuncio FOREIGN KEY (numero_anuncio) REFERENCES Anuncio(numero_anuncio)
);

CREATE TABLE Comentario (
    email_usuario VARCHAR(255) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    conteudo VARCHAR(255),
    status VARCHAR(10),
    email_adm VARCHAR(255),
    numero_transmissao INT NOT NULL,
    PRIMARY KEY (email_usuario, data_hora),
    CONSTRAINT fk_comentario_usuario FOREIGN KEY (email_usuario) REFERENCES Usuario(email),
    CONSTRAINT fk_comentario_adm FOREIGN KEY (email_adm) REFERENCES Usuario(email),
    CONSTRAINT fk_comentario_transmissao FOREIGN KEY (numero_transmissao) REFERENCES Transmissao(numero_transmissao)
);

CREATE TABLE Banimento (
    email_adm VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    tipo_conta VARCHAR(50),
    PRIMARY KEY (email_adm, email_usuario, data_hora),
    CONSTRAINT fk_banimento_adm FOREIGN KEY (email_adm) REFERENCES Usuario(email),
    CONSTRAINT fk_banimento_usuario FOREIGN KEY (email_usuario) REFERENCES Usuario(email)
);

CREATE TABLE Time (
    nome_time VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Atleta (
    CPF VARCHAR(11) PRIMARY KEY,
    nome_time VARCHAR(50),
    nome VARCHAR(50),
    data_nascimento DATE,
    CONSTRAINT fk_atleta_time FOREIGN KEY (nome_time) REFERENCES Time(nome_time)
);

CREATE TABLE Evento_time (
    nome_time VARCHAR(50) NOT NULL,
    nome_evento VARCHAR(50) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    PRIMARY KEY (nome_time, nome_evento, data_hora),
    CONSTRAINT fk_eventoTime_time FOREIGN KEY (nome_time) REFERENCES Time(nome_time),
    CONSTRAINT fk_eventoTime_evento FOREIGN KEY (nome_evento, data_hora) REFERENCES Evento_esportivo(nome_evento, data_hora)
);

CREATE TABLE Tag (
    nome VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Tag_transmissao (
    nome_tag VARCHAR(50) NOT NULL,
    numero_transmissao INT NOT NULL,
    PRIMARY KEY (nome_tag, numero_transmissao),
    CONSTRAINT fk_tagTransmissao_tag FOREIGN KEY (nome_tag) REFERENCES Tag(nome),
    CONSTRAINT fk_tagTransmissao_transmissao FOREIGN KEY (numero_transmissao) REFERENCES Transmissao(numero_transmissao)
);
