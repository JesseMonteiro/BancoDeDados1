-- Definição de Tabelas
CREATE TABLE automovel (
	placa varchar(8), 
	cpf_proprietario varchar(14)
	);

CREATE TABLE segurado (
	cpf varchar(14), 
	seguro_id integer, 
	nome varchar(40)
	);

CREATE TABLE perito (
	cpf varchar(14), 
	nome varchar(40)
	);

CREATE TABLE oficina (
	nome varchar(40), 
	cnpj varchar(16)
	);

CREATE TABLE seguro (
	cod_seguro serial, 
	cobertura text, 
	validade date
);

CREATE TABLE sinistro (
	sinistro_id serial, 
	descricao text, 
	segurado_id integer, 
	placa varchar(8)
	);

CREATE TABLE pericia (
	pericia_id seriaL, 
	sinistro_id integer, 
	placa_veiculo varchar(8), 
	perito_id integer, 
	cnpj_oficina varchar(16), 
	perda_total boolean, 
	reparo_id integer
	);


CREATE TABLE reparo (
	reparo_id serial, 
	placa varchar(8), 
	cnpj_oficina varchar(16), 
	pericia_id integer
	);

-- Adicionar chave primaria
ALTER TABLE automovel ADD PRIMARY KEY (placa);

ALTER TABLE segurado ADD PRIMARY KEY (cpf);

ALTER TABLE perito ADD PRIMARY KEY (cpf);

ALTER TABLE oficina ADD PRIMARY KEY (cnpj);

ALTER TABLE seguro ADD PRIMARY KEY (codseguro);

ALTER TABLE sinistro ADD PRIMARY KEY (sinistro_id);

ALTER TABLE pericia ADD PRIMARY KEY (pericia_id);

ALTER TABLE reparo ADD PRIMARY KEY (reparo_id);


-- Adicionar Foreign key
ALTER TABLE sinistro ADD FOREIGN KEY (segurado_id) REFERENCES sinistro(sinistro_id);

ALTER TABLE sinistro ADD FOREIGN KEY (placa) REFERENCES automovel(placa);

ALTER TABLE pericia ADD FOREIGN KEY (sinistro_id) REFERENCES sinistro(sinistro_id);

ALTER TABLE pericia ADD FOREIGN KEY (placa_veiculo) REFERENCES automovel(placa);

-- Alterar o tipo de perito id em pericia para cpf
ALTER TABLE pericia ALTER COLUMN perito_id TYPE varchar(14);

-- Adicionar Foreign key
ALTER TABLE pericia ADD FOREIGN KEY (perito_id) REFERENCES perito(cpf); 

ALTER TABLE pericia ADD FOREIGN KEY (cnpj_oficina) REFERENCES oficina(cnpj);

ALTER TABLE reparo ADD FOREIGN KEY (placa) REFERENCES automovel(placa);

ALTER TABLE reparo ADD FOREIGN KEY (cnpj_oficina) REFERENCES oficina(cnpj);

ALTER TABLE reparo ADD FOREIGN KEY (pericia_id) REFERENCES pericia(pericia_id);



-- Adicionar constraint not nul automovel-cpf_proprietario
ALTER TABLE automovel ALTER COLUMN cpf_proprietario;

ALTER TABLE pericia ALTER COLUMN sinistro_id SET NOT NULL;

ALTER TABLE pericia ALTER COLUMN placa_veiculo SET NOT NULL;

ALTER TABLE pericia ALTER COLUMN perito_id SET NOT NULL;

ALTER TABLE pericia ALTER COLUMN cnpj_oficina SET NOT NULL;

ALTER TABLE segurado ALTER COLUMN seguro_id SET NOT NULL;

ALTER TABLE seguro ALTER COLUMN validade SET NOT NULL;

ALTER TABLE sinistro ALTER COLUMN segurado_id SET NOT NULL;

ALTER TABLE sinistro ALTER COLUMN placa SET NOT NULL;



-- Remover todas as tabelas
DROP TABLE seguro;
DROP TABLE segurado;
DROP TABLE pericia;
DROP TABLE perito;
DROP TABLE sinistro;
DROP TABLE automovel;
DROP TABLE oficina;


-- Recriando a tabela
CREATE TABLE automovel (
	placa varchar(8) PRIMARY KEY NOT NULL, 
	cpf varchar(11) NOT NULL
	);
CREATE TABLE oficina (
	cnpj varchar(16) PRIMARY KEY NOT NULL, 
	nome varchar(20)
	);
CREATE TABLE seguro (
	cod_seguro serial PRIMARY KEY NOT NULL, 
	cobertura text, 
	validade date NOT NULL
	);
CREATE TABLE segurado (
	cpf varchar(11) PRIMARY KEY NOT NULL, 
	seguro_id integer NOT NULL, 
	nome varchar(20),
	FOREIGN KEY (seguro_id) REFERENCES seguro(cod_seguro)
	);
CREATE TABLE sinistro (
	sinistro_id serial PRIMARY KEY NOT NULL, 
	descricao text, segurado_id varchar(11) NOT NULL, 
	placa varchar(8) NOT NULL, 
	FOREIGN KEY (segurado_id) REFERENCES segurado(cpf), 
	FOREIGN KEY (placa) REFERENCES automovel(placa)
	);
CREATE TABLE perito (
	cpf varchar(11) PRIMARY KEY NOT NULL, 
	nome varchar(20) NOT NULL
	);
CREATE TABLE pericia (
	cod_pericia serial PRIMARY KEY NOT NULL, 
	sinistro_id integer NOT NULL, 
	placa_veiculo varchar(8) NOT NULL, 
	perito_id varchar(11) NOT NULL, 
	cnpj_oficina varchar(16) NOT NULL, 
	perda_total boolean, 
	reparo integer, 
	FOREIGN KEY (sinistro_id) REFERENCES sinistro(sinistro_id), 
	FOREIGN KEY (placa_veiculo) REFERENCES automovel(placa), 
	FOREIGN KEY (perito_id) REFERENCES perito(cpf), 
	FOREIGN KEY (cnpj_oficina) REFERENCES oficina(cnpj)
	);
CREATE TABLE reparo (
	reparo_id serial PRIMARY KEY NOT NULL, 
	placa varchar(8) NOT NULL, 
	cnpj_oficina varchar(16) NOT NULL, 
	pericia_id integer NOT NULL, 
	FOREIGN KEY (placa) REFERENCES automovel(placa), 
	FOREIGN KEY (cnpj_oficina) REFERENCES oficina(cnpj), 
	FOREIGN KEY (pericia_id) REFERENCES pericia(cod_pericia)
	);


-- Removendo novamente a tabela
DROP TABLE reparo;
DROP TABLE pericia;
DROP TABLE perito;
DROP TABLE sinistro;
DROP TABLE segurado;
DROP TABLE seguro;
DROP TABLE oficina;
DROP TABLE automovel;