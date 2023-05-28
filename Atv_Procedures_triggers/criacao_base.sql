USE atv_procedures;

-- Table: CARGO
CREATE TABLE CARGO (
CD_CARGO integer AUTO_INCREMENT NOT NULL,
DS_CARGO varchar(50) NULL,
CONSTRAINT CARGO_pk PRIMARY KEY (CD_CARGO)
);

-- Table: CATEGORIA
CREATE TABLE CATEGORIA (
CD_CATEGORIA integer AUTO_INCREMENT NOT NULL,
DS_CATEGORIA varchar(50) NULL,
CONSTRAINT CATEGORIA_pk PRIMARY KEY (CD_CATEGORIA)
);

-- Table: CLIENTE
CREATE TABLE CLIENTE (
CD_CLIENTE int AUTO_INCREMENT NOT NULL,
NM_CLIENTE varchar(50) NOT NULL,
DS_EMAIL varchar(50) NOT NULL,
NR_TELEFONE varchar(15) NOT NULL,
CONSTRAINT CLIENTE_pk PRIMARY KEY (CD_CLIENTE)
);

-- Table: FUNCIONARIO
CREATE TABLE FUNCIONARIO (
CD_FUNCIONARIO integer AUTO_INCREMENT NOT NULL,
CD_CARGO integer NOT NULL,
NM_FUNCIONARIO varchar(50) NULL,
CONSTRAINT FUNCIONARIO_pk PRIMARY KEY (CD_FUNCIONARIO)
);

-- Table: HOSPEDAGEM
CREATE TABLE HOSPEDAGEM (
CD_HOSPEDAGEM int AUTO_INCREMENT NOT NULL,
DT_ENTRADA date NOT NULL,
DT_SAIDA date NOT NULL,
FL_SITUACAO char(1) NOT NULL,
CD_CLIENTE int NOT NULL,
CD_FUNCIONARIO integer NOT NULL,
NR_QUARTO integer NOT NULL,
CONSTRAINT HOSPEDAGEM_pk PRIMARY KEY (CD_HOSPEDAGEM)
);

-- Table: HOSPEDAGEM_SERVICO
CREATE TABLE HOSPEDAGEM_SERVICO (
CD_HOSPEDAGEM int NOT NULL,
CD_SERVICO integer NOT NULL,
NR_SEQUENCIA int NOT NULL,
DT_SOLICITACAO date NOT NULL,
CONSTRAINT HOSPEDAGEM_SERVICO_pk PRIMARY KEY (CD_HOSPEDAGEM,CD_SERVICO,NR_SEQUENCIA)
);

-- Table: QUARTO
CREATE TABLE QUARTO (
NR_QUARTO integer NOT NULL,
CD_CATEGORIA integer NOT NULL,
DS_QUARTO varchar(50) NULL,
NR_OCUPANTES integer NULL,
CONSTRAINT QUARTO_pk PRIMARY KEY (NR_QUARTO)
);

-- Table: RESERVA
CREATE TABLE RESERVA (
NR_RESERVA int AUTO_INCREMENT NOT NULL ,
DT_RESERVA date NOT NULL,
DT_ENTRADA date NOT NULL,
QT_DIARIAS int NOT NULL,
FL_SITUACAO char(1) NOT NULL,
CD_CLIENTE int NOT NULL,
NR_QUARTO integer NOT NULL,
CD_FUNCIONARIO integer NOT NULL,
CONSTRAINT RESERVA_pk PRIMARY KEY (NR_RESERVA)
);

-- Table: SERVICO

CREATE TABLE SERVICO (
CD_SERVICO integer AUTO_INCREMENT NOT NULL,
DS_SERVICO varchar(50) NULL,
CONSTRAINT SERVICO_pk PRIMARY KEY (CD_SERVICO)
);

-- foreign keys
-- Reference: FK_1 (table: QUARTO)
ALTER TABLE QUARTO ADD CONSTRAINT FK_1 FOREIGN KEY FK_1 (CD_CATEGORIA)
REFERENCES CATEGORIA (CD_CATEGORIA);

-- Reference: FK_3 (table: FUNCIONARIO)
ALTER TABLE FUNCIONARIO ADD CONSTRAINT FK_3 FOREIGN KEY FK_3 (CD_CARGO)
REFERENCES CARGO (CD_CARGO);

-- Reference: HOSPEDAGEM_CLIENTE (table: HOSPEDAGEM)
ALTER TABLE HOSPEDAGEM ADD CONSTRAINT HOSPEDAGEM_CLIENTE FOREIGN KEY HOSPEDAGEM_CLIENTE (CD_CLIENTE)
REFERENCES CLIENTE (CD_CLIENTE);

-- Reference: HOSPEDAGEM_FUNCIONARIO (table: HOSPEDAGEM)
ALTER TABLE HOSPEDAGEM ADD CONSTRAINT HOSPEDAGEM_FUNCIONARIO FOREIGN KEY HOSPEDAGEM_FUNCIONARIO (CD_FUNCIONARIO)
REFERENCES FUNCIONARIO (CD_FUNCIONARIO);

-- Reference: HOSPEDAGEM_QUARTO (table: HOSPEDAGEM)
ALTER TABLE HOSPEDAGEM ADD CONSTRAINT HOSPEDAGEM_QUARTO FOREIGN KEY HOSPEDAGEM_QUARTO (NR_QUARTO)
REFERENCES QUARTO (NR_QUARTO);

-- Reference: RESERVA_CLIENTE (table: RESERVA)
ALTER TABLE RESERVA ADD CONSTRAINT RESERVA_CLIENTE FOREIGN KEY RESERVA_CLIENTE (CD_CLIENTE)
REFERENCES CLIENTE (CD_CLIENTE);

-- Reference: RESERVA_FUNCIONARIO (table: RESERVA)
ALTER TABLE RESERVA ADD CONSTRAINT RESERVA_FUNCIONARIO FOREIGN KEY RESERVA_FUNCIONARIO (CD_FUNCIONARIO)
REFERENCES FUNCIONARIO (CD_FUNCIONARIO);

-- Reference: RESERVA_QUARTO (table: RESERVA)
ALTER TABLE RESERVA ADD CONSTRAINT RESERVA_QUARTO FOREIGN KEY RESERVA_QUARTO (NR_QUARTO)
REFERENCES QUARTO (NR_QUARTO);

-- Reference: Table_14_HOSPEDAGEM (table: HOSPEDAGEM_SERVICO)
ALTER TABLE HOSPEDAGEM_SERVICO ADD CONSTRAINT Table_14_HOSPEDAGEM FOREIGN KEY Table_14_HOSPEDAGEM (CD_HOSPEDAGEM)
REFERENCES HOSPEDAGEM (CD_HOSPEDAGEM);

-- Reference: Table_14_SERVICO (table: HOSPEDAGEM_SERVICO)
ALTER TABLE HOSPEDAGEM_SERVICO ADD CONSTRAINT Table_14_SERVICO FOREIGN KEY Table_14_SERVICO (CD_SERVICO)
REFERENCES SERVICO (CD_SERVICO);

-- INSERÇÃO DE DADOS NAS ESTRUTURAS

INSERT INTO cargo (ds_cargo) VALUES ('Gerente');

INSERT INTO cargo (ds_cargo) VALUES ('Recepcionista');
INSERT INTO cargo (ds_cargo) VALUES ('Atendente Geral');
INSERT INTO cargo (ds_cargo) VALUES ('Estagiário');

INSERT INTO funcionario (cd_cargo, nm_funcionario)
VALUES (1,'João Gerente Fonseca');
INSERT INTO funcionario (cd_cargo, nm_funcionario)
VALUES (2,'Maria Recepcionista da Silva');
INSERT INTO funcionario (cd_cargo, nm_funcionario)
VALUES (3,'Carlos Atendente Geral Costa');
INSERT INTO funcionario (cd_cargo, nm_funcionario)
VALUES (4,'Luiza Estagiária Souza');

INSERT INTO servico (ds_servico) VALUES ('Restaurante');
INSERT INTO servico (ds_servico) VALUES ('Bar');
INSERT INTO servico (ds_servico) VALUES ('Lavanderia');
INSERT INTO servico (ds_servico) VALUES ('Translado');
INSERT INTO servico (ds_servico) VALUES ('Lan house');

INSERT INTO categoria (ds_categoria) VALUES ('Standart Solteiro');
INSERT INTO categoria (ds_categoria) VALUES ('Standart Casal');
INSERT INTO categoria (ds_categoria) VALUES ('Master Solteiro');
INSERT INTO categoria (ds_categoria) VALUES ('Master Casal');
INSERT INTO categoria (ds_categoria) VALUES ('Deluxe Casal');

INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)

VALUES (101,1,'Corredor amarelo, face norte',1);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (103,1,'Corredor amarelo, face norte',1);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (105,1,'Corredor amarelo, face norte',1);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (102,2,'Corredor verde, face sul',2);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (104,2,'Corredor verde, face sul',2);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (106,2,'Corredor verde, face sul',2);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (201,3,'Corredor amarelo, face norte',1);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (203,3,'Corredor amarelo, face norte',1);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (205,3,'Corredor amarelo, face norte',1);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (202,4,'Corredor verde, face sul',2);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (204,4,'Corredor verde, face sul',2);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (206,4,'Corredor verde, face sul',2);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (301,5,'Corredor amarelo, face norte',2);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (303,5,'Corredor amarelo, face norte',2);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (302,5,'Corredor verde, face sul',2);
INSERT INTO quarto (nr_quarto, cd_categoria, ds_quarto, nr_ocupantes)
VALUES (304,5,'Corredor verde, face sul',2);


INSERT INTO cliente (nm_cliente, ds_email, nr_telefone)
VALUES ('Cliente 1','cliente1@provedor.com.br','47999990000');
INSERT INTO cliente (nm_cliente, ds_email, nr_telefone)
VALUES ('Cliente 2','cliente2@provedor.com.br','47888880000');
INSERT INTO cliente (nm_cliente, ds_email, nr_telefone)
VALUES ('Cliente 3','cliente3@provedor.com.br','47777770000');
INSERT INTO cliente (nm_cliente, ds_email, nr_telefone)
VALUES ('Cliente 4','cliente4@provedor.com.br','47666660000');
INSERT INTO cliente (nm_cliente, ds_email, nr_telefone)
VALUES ('Cliente 5','cliente5@provedor.com.br','47555550000');