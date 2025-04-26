create database SoyTrack;

use SoyTrack;


-- TABELAS

create table empresa(
idEmpresa int primary key auto_increment,
token char(8) unique,
nome varchar(45),
cnpj char(14),
email varchar(45),
telefone char(11),
logradouro varchar(45),
num varchar(5),
bairro varchar(45),
cidade varchar(45),
UF char(2),
CEP char(8)
);

create table funcionario(
idFuncionario int auto_increment,
nivel INT,
nome varchar(45),
email varchar(45),
senha varchar(30),
FKempresaf int,
constraint CHKnivel 
	check (nivel in (0, 1)),
constraint PKfkidFUNCIONARIO primary key (idFuncionario, FKempresaf),
constraint FKempresafuncionario foreign key (FKempresaf)
	references empresa(idEmpresa)
);

create table silo(
idSilo int primary key auto_increment,
altura float,
diametro float, 
FKempresa int,
constraint FKempresasilo foreign key (FKempresa)
	references empresa(idEmpresa)
);

create table sensor(
idSensor int primary key auto_increment,
nome varchar(10),
distanciaMAX float,
FKsilo int unique,
constraint FKsilosensor foreign key (FKsilo)
	references silo(idSilo)
);

create table registro(
idRegistro int auto_increment,
distancia decimal(5,2),
dtRegistro datetime default current_timestamp,
temIrregularidade boolean,
FKsensor int,
constraint PKfkidREGISTRO primary key (idRegistro, FKsensor),
constraint FKsensorregistro foreign key (FKsensor)
	references sensor(idSensor)
);


-- INSERTS

insert into empresa (token, nome, cnpj, email, telefone, logradouro, num, bairro, cidade, UF, CEP) values
('58173902', 'Sementec', '98765432000110', 'sementec@email.com', '11983472651',  'Rua das Sementes', '45', 'Bairro 123', 'Barreiras', 'BA', '02138879');

-- Inserindo as informações da empresa SEMENTEC

insert into funcionario (nivel, nome, email, senha, FKempresaf) values
('1', 'Rafael', 'rafael@sementec.com', 'rafael123', 1),
('0', 'Carla', 'carla@sementec.com', 'carla123', 1),
('0', 'João', 'joao@sementec.com', 'joao123', 1),
('0', 'Marcio', 'marcio@sementec.com', 'marcio123', 1);


insert into silo(altura, diametro, FKempresa) values
(7, 7, 1),
(7, 5, 1),
(7, 5, 1);

insert into sensor (nome, distanciaMAX, FKsilo) values
('HC-SR04', 1, 1),
('HC-SR04', 1, 2),
('HC-SR04', 1, 3);

-- SELECTS


select empresa.nome as Empresa,
		funcionario.nome as Funcionários,
        case when funcionario.nivel = 1 then 'Avançado'
        else 'Comum' end as 'Nível de Acesso'
        from empresa join funcionario
			on idEmpresa = FKempresaf
		where idEmpresa = 1;
        
        
select  concat(7 - r.distancia, 'm') as 'Nível dos grãos do silo 1: SEMENTEC',
        r.dtRegistro as Horário,
        case when r.temIrregularidade = 1 then 'Irregular'
        else 'Regular' end as 'Irregularidades'
        from empresa join silo 
        on idEmpresa = FKempresa
        join sensor 
        on idSilo = FKsilo
        join registro as r
        on idSensor = FKsensor
        where empresa.idEmpresa = 1 and silo.idSilo = 1;