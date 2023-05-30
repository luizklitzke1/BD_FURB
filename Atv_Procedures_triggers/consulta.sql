##Aluno: Luiz Gustavo Klitzke.
#Construção de gatilhos/rotinas para:

#a) manter um log com todas as operações DML (insert, update e delete) realizadas na tabela cliente. 
#Dica, criar uma tabela e registrar os eventos (logs) com: data, hora, operação realizada e usuário. 
#Utilize o usuário logado na seção (função user()) para saber o usuário que executou a operação. 
#Importante: nos casos que envolve alterações (update), registrar no logo o valor antigo e o novo valor (alterado);

CREATE TABLE IF NOT EXISTS log_operacoes_cliente
(
	dt_operacao DATE         NOT NULL,
	hr_operacao TIME         NOT NULL,
	ds_operacao VARCHAR(10)  NOT NULL,
	nm_usuario  VARCHAR(30)  NOT NULL,
	cd_cliente  INT          NOT NULL,
	vl_antigo   VARCHAR(250)         ,
	vl_novo     VARCHAR(250)
);

DELIMITER $$
CREATE OR REPLACE TRIGGER tg_insercao_cliente AFTER INSERT ON atv_procedures.cliente
FOR EACH ROW
BEGIN 
	INSERT INTO log_operacoes_cliente (dt_operacao, hr_operacao, ds_operacao, nm_usuario, cd_cliente     )
										VALUES (CURDATE()  , CURTIME()  , "INSERT"   , USER()    , NEW.CD_CLIENTE );
END $$    

DELIMITER $$
CREATE OR REPLACE TRIGGER tg_update_cliente AFTER UPDATE ON atv_procedures.cliente
FOR EACH ROW
BEGIN 
	INSERT INTO log_operacoes_cliente (dt_operacao, hr_operacao, ds_operacao, nm_usuario, cd_cliente     , vl_antigo, vl_novo)
					               VALUES (CURDATE()  , CURTIME()  , "UPDATE"   , USER()    , OLD.CD_CLIENTE ,
										        CONCAT("cd_cliente = ", OLD.cd_cliente, ", nm_cliente = ", OLD.nm_cliente, "ds_email = ", OLD.ds_email, ", nr_telefone = ", OLD.nr_telefone), 
												  CONCAT("cd_cliente = ", NEW.cd_cliente, ", nm_cliente = ", NEW.nm_cliente, "ds_email = ", NEW.ds_email, ", nr_telefone = ", NEW.nr_telefone));
END $$   

DELIMITER $$
CREATE OR REPLACE TRIGGER tg_delete_cliente AFTER DELETE ON atv_procedures.cliente
FOR EACH ROW
BEGIN 
	INSERT INTO log_operacoes_cliente (dt_operacao, hr_operacao, ds_operacao, nm_usuario, cd_cliente     )
					               VALUES (CURDATE()  , CURTIME()  , "DELETE"   , USER()    , OLD.CD_CLIENTE );
END $$ 

#b) criar uma rotina que sinalize (liste) a disponibilidade de quarto(s), ou seja sem reserva, considerando uma determinada data passada com parâmetro;
DELIMITER $$
CREATE OR REPLACE PROCEDURE pc_lista_quartos_disponiveis(IN dt_disponivel DATE)
BEGIN
    SELECT q.NR_QUARTO
    FROM quarto q
    LEFT JOIN reserva r ON q.NR_QUARTO = r.NR_QUARTO
    WHERE r.NR_RESERVA IS NULL OR (dt_disponivel NOT BETWEEN r.DT_ENTRADA AND DATE_ADD(r.DT_ENTRADA, INTERVAL r.QT_DIARIAS - 1 DAY))
    ORDER BY q.NR_QUARTO ASC;
END $$

CALL pc_lista_quartos_disponiveis(DATE '2023-05-28');

#c) criar uma rotina para adicionar uma hospedagem passando como parâmetros: cliente (o seu cadastro, ou seja, seu id/nome), quarto, data de entrada e 
#data prevista de saída. Utilizar cd_funcionario (1) visto que não teremos controle de autenticação, e fl_situacao ('O') para ocupado.  
#Atenção para a validação da reserva do cliente, pois a hospedagem só deve acontecer se houver reserva prévia;

DELIMITER $$
CREATE OR REPLACE PROCEDURE pc_adicionar_hospedagem(IN cd_cliente INT, IN nr_quarto INT, IN dt_entrada DATE, IN dt_saida DATE)
BEGIN
  DECLARE qtd_reservas INT;
  
  #Buscar reservas do cliente para esse quarto
  SELECT COUNT(*) INTO qtd_reservas
  FROM reserva AS r
  WHERE r.CD_CLIENTE = cd_cliente AND r.NR_QUARTO = nr_quarto
    AND r.DT_ENTRADA = dt_entrada AND DATE_ADD(r.DT_ENTRADA, INTERVAL r.QT_DIARIAS - 1 DAY) >= dt_saida;
  
  IF qtd_reservas > 0 THEN
    INSERT INTO hospedagem (DT_ENTRADA, DT_SAIDA, FL_SITUACAO, CD_CLIENTE, CD_FUNCIONARIO, NR_QUARTO)
    VALUES (dt_entrada, dt_saida, 'O', cd_cliente, 1, nr_quarto);
  END IF;
END $$

CALL pc_adicionar_hospedagem(1, 101, '2023-05-28', '2023-05-30');

#d) criar uma rotina para adicionar um serviço a uma determinada hospedagem. Considerar os seguintes parâmetros: identificação da hospedagem e serviço.
#Atenção para a data de solicitação que deve ser a atual e o número de sequência 
#(que deve seguir incremental apenas dentro do número da hospedagem, ou seja, este número é zerado para cada nova hospedagem);

DELIMITER $$
CREATE OR REPLACE PROCEDURE pc_adicionar_servico_hospedagem(IN cd_hospedagem INT, IN cd_servico INT)
BEGIN
  DECLARE nr_sequencia_atual INT;
  
  SELECT MAX(os.NR_SEQUENCIA) INTO nr_sequencia_atual
  FROM hospedagem_servico AS os
  WHERE os.CD_HOSPEDAGEM = cd_hospedagem AND os.CD_SERVICO = cd_servico;
  
  IF nr_sequencia_atual IS NULL THEN
		SET nr_sequencia_atual = 0;
  END IF;
  
  INSERT INTO hospedagem_servico (CD_HOSPEDAGEM, CD_SERVICO, NR_SEQUENCIA, DT_SOLICITACAO)
  VALUES (cd_hospedagem, cd_servico, nr_sequencia_atual + 1, CURRENT_DATE);
END $$

CALL pc_adicionar_servico_hospedagem(2, 3);
CALL pc_adicionar_servico_hospedagem(1, 1);
CALL pc_adicionar_servico_hospedagem(2, 2);
CALL pc_adicionar_servico_hospedagem(2, 3);

#e) criar uma rotina para mudar o status (coluna fl_situacao) para 'F' - finalizada. Esta rotina deverá receber como parâmetro o identificador da hospedagem. 
DELIMITER $$
CREATE OR REPLACE PROCEDURE pc_finalizar_hospedagem (IN cd_hospedagem INT)
BEGIN
  UPDATE hospedagem AS h
  SET h.FL_SITUACAO = 'F'
  WHERE h.CD_HOSPEDAGEM = cd_hospedagem;
END $$

CALL pc_finalizar_hospedagem(5);