#Selecionar, inserir e apagar em tabelas arbitrárias
INSERT INTO cliente (CD_CLIENTE, NM_CLIENTE, DS_EMAIL, NR_TELEFONE) VALUES
(22, 'Luiz G Klitzke', 'cliente22@provedor.com.br', '4799990000');
SELECT * FROM  cliente;

SELECT * FROM  cargo;
INSERT INTO servico (CD_SERVICO, DS_SERVICO) VALUES
(23, 'Testador');
DELETE FROM servico WHERE servico.CD_SERVICO = 23;

#Adicionar e remover permissões
GRANT INSERT ON hospedagem_servico TO "Recepcionista";
REVOKE INSERT ON hospedagem_servico FROM "Recepcionista";

#Select com nome do aluno
SELECT * FROM funcionario WHERE funcionario.NM_FUNCIONARIO = "Luiz G Klitzke";