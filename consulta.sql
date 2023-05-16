#Aluno: Luiz Gustavo Klitzke

INSERT INTO atv_permissoes.funcionario (CD_FUNCIONARIO, CD_CARGO, NM_FUNCIONARIO) VALUES
(9, 1, "Luiz G Klitzke");

USE atv_permissoes;

#1) Criação dos grupos (papéis);
CREATE OR REPLACE ROLE "Gerente";
CREATE OR REPLACE ROLE "Recepcionista";
CREATE OR REPLACE ROLE "Atendente Geral";

#2) Designação dos privilégios para cada um dos grupos criados;

#b) O grupo "Gerente" poderá realizar qualquer operação sobre os dados, 
# além de definir acesso (conceder direitos - ver "with grant option") a outros usuários;;
GRANT ALL PRIVILEGES ON atv_permissoes.* TO "Gerente" WITH GRANT OPTION;

#c) O grupo "Reepcionista" poderá realizar todas as operações sobre as estruturas: cliente, reserva e hospedagem;
GRANT ALL PRIVILEGES ON atv_permissoes.cliente    TO "Recepcionista";
GRANT ALL PRIVILEGES ON atv_permissoes.reserva    TO "Recepcionista";
GRANT ALL PRIVILEGES ON atv_permissoes.hospedagem TO "Recepcionista";

#d) O grupo de usuários "Atendente Geral" poderá apenas realizar leitura dos dados do cliente 
#(nome e número do quarto em que está hospedado) e realizar operações de inclusão e alteração na estrutura hospedagem serviço. 
#Dica: avaliar possibilidade de utilização de uma visão (view) pra limitar o acesso aos dados do cliente/hospedagem.

CREATE OR REPLACE VIEW dados_do_cliente AS
SELECT cliente.NM_CLIENTE, hospedagem.NR_QUARTO
FROM atv_permissoes.cliente
INNER JOIN atv_permissoes.hospedagem ON cliente.CD_CLIENTE = hospedagem.CD_CLIENTE;

GRANT SELECT ON dados_do_cliente TO "Atendente Geral";
GRANT SELECT, INSERT, UPDATE ON atv_permissoes.hospedagem_servico TO "Atendente Geral";

#3) Criação de, no mínimo, um usuário para cada grupo criado;
CREATE OR REPLACE USER marcos IDENTIFIED BY "marcao123";
GRANT "Gerente" TO marcos;
SET DEFAULT role "Gerente" FOR marcos;

CREATE OR REPLACE USER joana IDENTIFIED BY "joaninha2215";
GRANT "Recepcionista" TO joana;
SET DEFAULT role "Recepcionista" FOR joana;

CREATE OR REPLACE USER tobias IDENTIFIED BY "senhadotobiashehe";
GRANT "Atendente Geral" TO tobias;
SET DEFAULT role "Atendente Geral" FOR tobias;