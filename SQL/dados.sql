-- 1. Inserir dados na tabela Localizacao com IDs automáticos gerados (usando SERIAL)
INSERT INTO Localizacao (id_localizacao, cidade, estado, pais)
VALUES 
    (34245677, 'São Paulo', 'São Paulo', 'Brasil'),
    (56645677, 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil');

-- 2. Inserir dados na tabela Usuario com IDs numéricos longos
INSERT INTO Usuario (email, nome, data_nascimento, tipo_conta)
VALUES 
    ('user34245689@email.com', 'Alice Silva', '1990-05-15', 'comum'),
    ('user98765432@email.com', 'Bruno Costa', '1985-08-20', 'premium'),
	('admin98765432@email.com', 'Denis Silva', '1985-08-20', 'admin'),
	('admin34245689@email.com', 'Maria Santos', '1985-08-20', 'admin'),
	('joao.silva@email.com', 'João Silva', '1992-03-10', 'comum'),
    ('user12345678@email.com', 'Carla Mendes', '1992-03-10', 'comum');

-- 3. Inserir dados na tabela Esporte
INSERT INTO Esporte (nome_esporte, popularidade, categoria)
VALUES 
    ('Vôlei', 4, 'Indoor'),
    ('Handebol', 3, 'Indoor'),
    ('Basquete', 5, 'Indoor');

-- 4. Inserir dados na tabela Instalacao_esportiva com IDs válidos de localizacao
-- Agora podemos inserir as instalações, utilizando os IDs gerados automaticamente.
-- O PostgreSQL gera automaticamente o id_localizacao para cada inserção na tabela Localizacao.
INSERT INTO Instalacao_esportiva (nome_instalacao, id_localizacao)
VALUES 
    ('Ginásio do Ibirapuera', 34245677),  -- id_localizacao = 1, refere-se à 'São Paulo'
    ('Maracanãzinho', 56645677);  -- id_localizacao = 2, refere-se à 'Rio de Janeiro'

-- 5. Inserir dados na tabela Evento_esportivo com IDs válidos de instalações
INSERT INTO Evento_esportivo (nome_evento, data_hora, nome_instalacao)
VALUES 
    ('Campeonato Nacional de Vôlei', '2024-12-01 14:00:00', 'Ginásio do Ibirapuera'),
    ('Copa Regional de Handebol', '2024-12-02 15:00:00', 'Maracanãzinho');

INSERT INTO Evento_esportivo (nome_evento, data_hora, nome_instalacao)
VALUES 
	('Copa de Santos de Handebol', '2024-12-22 15:00:00', 'Maracanãzinho'),
	('Copa de Campinas de Handebol', '2025-11-23 15:00:00', 'Maracanãzinho'),
	('Copa de Araraquara de Handebol', '2025-10-15 15:00:00', 'Maracanãzinho');

-- 6. Inserir dados na tabela Transmissao com números longos para transmissões
INSERT INTO Transmissao (numero_transmissao, horario_inicio, duracao, qualidade, nome_esporte, nome_evento, horario_evento)
VALUES 
    (34245689,'2024-12-01 14:00:00', 120, '1080p', 'Vôlei', 'Campeonato Nacional de Vôlei', '2024-12-01 14:00:00'),
    (98765432,'2024-12-02 15:00:00', 90, '720p', 'Handebol', 'Copa Regional de Handebol', '2024-12-02 15:00:00');

-- 7. Inserir dados na tabela Anuncio com links longos
INSERT INTO Anuncio (numero_anuncio, link_nuvem)
VALUES 
    (34245689, 'http://cloudstorage.com/ads/34245689'),
    (98765432, 'http://cloudstorage.com/ads/98765432');

-- 8. Inserir dados na tabela Transmissao_Usuario com números longos para transmissões e e-mails
INSERT INTO Transmissao_Usuario (numero_transmissao, email_usuario)
VALUES 
    (34245689, 'joao.silva@email.com'),
    (98765432, 'joao.silva@email.com'),
	(34245689, 'user34245689@email.com'),
    (98765432, 'user34245689@email.com'),
    (34245689, 'user98765432@email.com'),
    (98765432, 'user98765432@email.com'),
    (34245689, 'user12345678@email.com'),
    (98765432, 'user12345678@email.com');

-- 9. Inserir dados na tabela User_transm_anuncio com IDs longos para transmissões e anúncios
INSERT INTO User_transm_anuncio (numero_transmissao, email_usuario, numero_anuncio)
VALUES 
    (34245689, 'user34245689@email.com', 34245689),
    (98765432, 'user34245689@email.com', 98765432),
    (34245689, 'user98765432@email.com', 34245689),
    (98765432, 'user98765432@email.com', 98765432),
    (34245689, 'user12345678@email.com', 34245689),
    (98765432, 'user12345678@email.com', 98765432);

-- 10. Inserir dados na tabela Comentario com IDs longos para usuário e admins
INSERT INTO Comentario (email_usuario, data_hora, conteudo, status, email_adm, numero_transmissao)
VALUES 
    ('user34245689@email.com', '2024-12-01 14:30:00', 'Ótima transmissão!', 'aprovado', 'admin34245689@email.com', 34245689),
    ('user34245689@email.com', '2024-12-02 15:30:00', 'Adorei a transmissão de handebol!', 'aprovado', 'admin98765432@email.com', 98765432),
    ('user98765432@email.com', '2024-12-01 15:00:00', 'Muito boa a qualidade do vídeo!', 'aprovado', 'admin34245689@email.com', 34245689),
    ('user12345678@email.com', '2024-12-01 14:45:00', 'Bacana ver jogos de vôlei!', 'aprovado', 'admin98765432@email.com', 34245689),
    ('user12345678@email.com', '2024-12-02 15:45:00', 'O jogo de handebol foi emocionante!', 'aprovado', 'admin34245689@email.com', 98765432);

-- 11. Inserir dados na tabela Banimento com IDs longos para admin e usuário
INSERT INTO Banimento (email_adm, email_usuario, data_hora, tipo_conta)
VALUES 
    ('admin34245689@email.com', 'user12345678@email.com', '2024-12-05 10:00:00', 'comum');

-- 12. Inserir dados na tabela Time com nomes reais de times (sem números longos)
INSERT INTO Time (nome_time)
VALUES 
    ('Flamengo'),
    ('Vasco da Gama');

-- 13. Inserir dados na tabela Atleta com IDs longos para CPF
INSERT INTO Atleta (CPF, nome_time, nome, data_nascimento)
VALUES 
    ('12345678901', 'Flamengo', 'João Silva', '1995-07-10'),
    ('98765432100', 'Vasco da Gama', 'Carlos Souza', '1990-11-20');

-- 14. Inserir dados na tabela Evento_time com relacionamentos longos
INSERT INTO Evento_time (nome_time, nome_evento, data_hora)
VALUES 
    ('Flamengo', 'Campeonato Nacional de Vôlei', '2024-12-01 14:00:00'),
    ('Vasco da Gama', 'Copa Regional de Handebol', '2024-12-02 15:00:00');

-- 15. Inserir dados na tabela Tag com tags significativas
INSERT INTO Tag (nome)
VALUES 
    ('Esportes'),
    ('Vôlei'),
    ('Handebol');

-- 16. Inserir dados na tabela Tag_transmissao com relacionamentos válidos
INSERT INTO Tag_transmissao (nome_tag, numero_transmissao)
VALUES 
    ('Vôlei', 34245689),
    ('Handebol', 98765432),
    ('Esportes', 34245689),
    ('Esportes', 98765432);

INSERT INTO Esporte (nome_esporte, popularidade, categoria)
VALUES 
    ('Futebol', 1, 'Outdoor');


	
INSERT INTO Transmissao (numero_transmissao, horario_inicio, duracao, qualidade, nome_esporte, nome_evento, horario_evento)
VALUES 
    (34247689,'2024-12-01 14:00:00', 120, '1080p', 'Handebol', 'Copa de Santos de Handebol', '2024-12-22 15:00:00'),
	(34247681,'2024-12-01 14:00:00', 120, '1080p', 'Handebol', 'Copa de Santos de Handebol', '2024-12-22 15:00:00'),
	(34247682,'2024-12-01 14:00:00', 120, '1080p', 'Handebol', 'Copa de Campinas de Handebol', '2025-11-23 15:00:00');

INSERT INTO Time (nome_time)
VALUES 
    ('Praia Clube'),
    ('Unopar');

INSERT INTO Evento_time (nome_time, nome_evento, data_hora)
VALUES 
    ('Unopar', 'Copa de Araraquara de Handebol', '2025-10-15 15:00:00'),
    ('Praia Clube', 'Copa de Campinas de Handebol', '2025-11-23 15:00:00');

INSERT INTO Transmissao_Usuario (numero_transmissao, email_usuario)
VALUES 
    (34247682, 'joao.silva@email.com'),
    (34247681, 'joao.silva@email.com'),
	(34247689, 'joao.silva@email.com');
