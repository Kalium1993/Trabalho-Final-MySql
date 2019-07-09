-- A

SELECT 
    al.nome AS Aluno,
    l.titulo AS Livro,
    r.dataRetirada AS 'Data de Retirada',
    r.previsaoEntrega AS 'Previsão da Entrega'
FROM
    retirada r
        INNER JOIN
    aluno al ON al.id = r.idAluno
        INNER JOIN
    livro l ON r.idLivro = l.id
WHERE
    l.id = 1
    && al.id = 1
        && dataRetirada BETWEEN DATE_ADD(current_date(), interval -7 day) AND DATE_ADD(current_date(), interval 7 day);

-- B

(select l.titulo as livro from livro l where l.id = 2)

union all

(select livroDisponivel(2));

-- C

SELECT 
    a.nome AS Atendente,
    l.titulo AS Livro,
    r.dataRetirada AS 'Data de Retirada',
    r.previsaoEntrega AS 'Previsão de Entrega',
    r.dataEntrega AS 'Data de Entrega'
FROM
    retirada r
        INNER JOIN
    atendente a ON a.id = r.idAtendente
        INNER JOIN
    livro l ON l.id = r.idLivro
WHERE
    r.dataEntrega  = DATE_ADD(current_date(), interval -1 day)
        or r.dataRetirada = DATE_ADD(current_date(), interval -1 day)
        && a.id = 1;

-- D

SELECT 
    l.titulo AS livro,
    l.categoria AS categoria,
    COUNT(r.dataRetirada) AS 'locações'
FROM
    retirada r
        INNER JOIN
    livro l ON r.idLivro = l.id
GROUP BY l.titulo
ORDER BY COUNT(r.dataRetirada) DESC
LIMIT 5;

-- E

SELECT 
    l.titulo AS livro, r.dataRetirada AS 'Data de Retirada'
FROM
    retirada r
        RIGHT JOIN
    livro l ON r.idLivro = l.id
WHERE
    YEAR(r.dataRetirada) < 2018
        OR r.dataRetirada IS NULL;

-- VIEW

select * from view_livrosDisponiveis;

-- LIVROS POR ATENDENTE

SELECT distinct 
    a.nome AS atendente, al.nome AS aluno
FROM
    retirada r
        INNER JOIN
    atendente a ON r.idAtendente = a.id
        INNER JOIN
    aluno al ON al.id = r.idAluno
 order by a.nome;


