create database SoyTrack;

use SoyTrack;

-- TABELAS

create table empresa(
idEmpresa  int primary key auto_increment,
cnpj char(14),
nome varchar(45),
logradouro varchar(45),
num varchar(5),
bairro varchar(45),
cidade varchar(45),
UF char(2),
CEP char(8)
);

create table token (
idToken char(8) primary key,
statustoken boolean,
dtCriacao datetime default current_timestamp,
duracaoHoras int,
FKempresa int,
constraint fkempresatoken foreign key (FKempresa)
	references empresa(idEmpresa)
);

create table nivelFunc (
idNivel int primary key auto_increment,
descricao varchar(45),
tipo int
);

create table funcionario(
idFuncionario int auto_increment,
nome varchar(45),
email varchar(45),
senha varchar(30),
permissao boolean,
FKempresa int,
FKnivel int not null,
constraint PKfkidFUNCIONARIO primary key (idFuncionario, FKempresa),
constraint FKempresafuncionario foreign key (FKempresa)
	references empresa(idEmpresa),
constraint FKnivelfuncionario foreign key (FKnivel)
	references nivelFunc(idNivel)
);

create table silo(
idSilo int primary key auto_increment,
altura float,
diametro float, 
FKempresa int,
constraint FKempresasilo foreign key (FKempresa)
	references empresa(idEmpresa)
);

create table parametro (
idParametro int primary key auto_increment,
distanciaMAX float,
nivel int
);

create table SiloParametro (
FKsilo int,
FKparametro int,
constraint PKsiloparametro primary key (FKsilo, FKparametro),
constraint FKsiloparametro foreign key (FKsilo)
	references silo(idSilo),
constraint FKparametrosilo foreign key (FKparametro)
	references parametro (idParametro)
);

create table sensor(
idSensor int primary key auto_increment,
nome varchar(10),
FKsilo int unique,
constraint FKsilosensor foreign key (FKsilo)
	references silo(idSilo)
);

create table captura(
idCaptura int auto_increment,
distancia float,
dtCaptura datetime default current_timestamp,
FKsensor int,
constraint PKfkidREGISTRO primary key (idCaptura, FKsensor),
constraint FKsensorregistro foreign key (FKsensor)
	references sensor(idSensor)
);

create table alerta (
idAlerta int auto_increment, 
nome varchar(45),
nivel int,
FKcaptura int,
constraint PKalerta primary key (idAlerta, FKcaptura),
constraint FKalertacaptura foreign key (FKcaptura)
	references captura(idCaptura)
);


-- INSERTS

insert into empresa (cnpj, nome, logradouro, num, bairro, cidade, UF, CEP) values
('98765432000110', 'Sementec', 'Rua das Sementes', '45', 'Bairro 123', 'Barreiras', 'BA', '02138879');

insert into token (idToken, statustoken, duracaoHoras, FKempresa) values
('99182237', 1, 3, 1);

insert into nivelFunc values
(default, 'Nível mais alto para usuários', 1),
(default, 'Nível mais baixo para usuários', 2),
(default, 'Nível específico para os desenvolvedores', 3);

insert into funcionario (nome, email, senha, permissao, FKempresa, FKnivel) values
('Rafael', 'rafael@sementec.com', 'rafael123', 1, 1, 1),
('Carla', 'carla@sementec.com', 'carla123', 1, 1, 2),
('João', 'joao@sementec.com', 'joao123', 1, 1, 2),
('Marcio', 'marcio@sementec.com', 'marcio123', 1, 1, 2);

insert into parametro (distanciaMAX, nivel) values
(1, 3),
(0.5, 2),
(0.2, 1);

insert into silo (altura, diametro, FKempresa) values
(7, 3.5, 1),
(7, 3.5, 1),
(7, 3.5, 1);

insert into SiloParametro values
(1, 1),
(1, 2),
(1, 3);

insert into sensor (nome, FKsilo) values
('HC-SR04', 1),
('HC-SR04', 2),
('HC-SR04', 3);

insert into captura (distancia, FKsensor) values
(7, 1),
(6, 1),
(5, 1),
(4, 1),
(3, 1),
(2, 1),
(1, 1),
(0.5, 1),
(0.2, 1);

insert into alerta (nome, nivel, FKcaptura) values
('Leve', 3, 7),
('Moderado', 2, 8),
('Grave', 1, 9);