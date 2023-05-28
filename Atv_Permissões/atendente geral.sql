SELECT * FROM cliente;
SELECT * FROM servico;
SELECT * FROM cargo;

INSERT INTO servico (CD_SERVICO, DS_SERVICO) VALUES
(23, 'Testador');
DELETE FROM servico WHERE servico.CD_SERVICO = 23;

#Acesar leitura dos dados do cliente (nome e número do quarto em que está hospedado) 
SELECT * FROM dados_do_cliente;

#Operações de inclusão e alteração na estrutura hospedagem serviço 
INSERT INTO hospedagem_servico ( CD_HOSPEDAGEM, CD_SERVICO, NR_SEQUENCIA , DT_SOLICITACAO)
VALUES (1, 1, 1, DATE '2015-01-02');

UPDATE hospedagem_servico SET CD_HOSPEDAGEM = 1
WHERE CD_HOSPEDAGEM = 2;

#Não diz nada sobre selecionar :D
SELECT * FROM hospedagem_servico;