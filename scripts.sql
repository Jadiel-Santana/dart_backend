SELECT * FROM usuarios;

INSERT INTO usuarios (nome, email, senha) VALUES ('Jadiel', 'jadiel.bsantana@gmail.com', '123456');
INSERT INTO usuarios (nome, email, senha) VALUES ('Augusto', 'augusto@email.com', '123456');
INSERT INTO usuarios (nome, email, senha, is_ativo) VALUES ('João', 'joao@email.com', '123456', 0);


SELECT * FROM noticias;

INSERT INTO noticias (titulo, descricao, id_usuario) VALUES ('NotÍcia XPTO', 'Se Chove a Terra Molha!!!!', 1);
INSERT INTO noticias (titulo, descricao, id_usuario) VALUES ('NotÍcia Quente', 'Hoje fez 30 graus', 2);
INSERT INTO noticias (titulo, descricao, id_usuario) VALUES ('NotÍcia Urgente', 'iPhone 14 é lancado', 1);
INSERT INTO noticias (titulo, descricao, id_usuario) VALUES ('Usuário inativo', 'Esse usuário foi desativado', 3);

SELECT
	n.titulo as 'Título',
    n.descricao as 'Descrição',
    n.dt_atualizacao 'Última atualização',
    u.nome as 'Autor'
FROM noticias n
INNER JOIN usuarios u ON u.id = n.id_usuario
WHERE u.nome like 'J%';

SELECT
	n.titulo as 'Título',
    n.descricao as 'Descrição',
    n.dt_atualizacao 'Última atualização',
    u.nome as 'Autor'
FROM noticias n
INNER JOIN usuarios u ON u.id = n.id_usuario
ORDER BY n.dt_atualizacao DESC;


