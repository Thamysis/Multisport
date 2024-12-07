-- Consulta as transmissoes de vôlei e retorna seus dados

SELECT numero_transmissao, horario_inicio, duracao, qualidade, nome_evento
FROM Transmissao
WHERE LOWER(nome_esporte) = 'vôlei';


-- Consulta os 3 últimos eventos assistidos pelo usuário "João Silva"
SELECT DISTINCT T.nome_evento
FROM (
    SELECT T.nome_evento, T.horario_inicio
    FROM Transmissao T
    JOIN Transmissao_Usuario TU ON T.numero_transmissao = TU.numero_transmissao
    JOIN (
        SELECT email
        FROM Usuario
        WHERE nome = 'João Silva'
        LIMIT 1  -- Garantir que apenas um resultado seja retornado para o JOIN
    ) U ON TU.email_usuario = U.email
    ORDER BY T.horario_inicio DESC
) AS T
LIMIT 3;


-- Consulta as próximas 3 transmissões de eventos esportivos de um time por meio do nome do time
SELECT DISTINCT 
    T.nome_evento AS evento_esportivo,
    T.horario_evento AS data_hora_transmissao
FROM 
    Transmissao T
JOIN 
    Evento_time ET 
    ON T.nome_evento = ET.nome_evento
    AND T.horario_evento = ET.data_hora
WHERE 
    ET.nome_time = 'Praia Clube' 
    AND T.horario_evento > NOW()
ORDER BY 
    T.horario_evento ASC
LIMIT 3;

-- Consulta os usuários que assistiram a todas as transmissões (com divisão relacional)
SELECT U.email, U.nome
FROM Usuario U
WHERE NOT EXISTS (
    SELECT T.numero_transmissao
    FROM Transmissao T
    WHERE NOT EXISTS (
        SELECT TU.numero_transmissao
        FROM Transmissao_Usuario TU
        WHERE TU.numero_transmissao = T.numero_transmissao
          AND TU.email_usuario = U.email
    )
);

-- Consulta os locais com maior número de eventos realizados
SELECT L.cidade, L.estado, COUNT(E.nome_evento) AS total_eventos
FROM Localizacao L
JOIN Instalacao_esportiva I
  ON L.id_localizacao = I.id_localizacao
JOIN Evento_esportivo E
  ON I.nome_instalacao = E.nome_instalacao
GROUP BY L.cidade, L.estado
HAVING COUNT(E.nome_evento) > 2;
