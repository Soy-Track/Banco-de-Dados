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