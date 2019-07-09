drop database trabalhoFinal;

create database trabalhoFinal;

use trabalhoFinal;

create table aluno (
	id int primary key auto_increment not null,
    nome varchar(45) not null
);

create table atendente (
	id int primary key auto_increment not null,
    nome varchar(45) not null
);

create table livro (
	id int primary key auto_increment not null,
    titulo varchar(45) not null,
    categoria varchar(45) not null
);

create table retirada (
	id int primary key auto_increment not null,
    dataRetirada date not null,
    previsaoEntrega date not null,
    dataEntrega date,
    idAluno int not null,
    idAtendente int not null,
    idLivro int not null,
    foreign key (idAluno) references aluno(id),
    foreign key (idAtendente) references atendente(id),
    foreign key (idLivro) references livro(id)
);

delimiter $ 
create function livroDisponivel(id int) returns char(40)
begin
	declare disp int;
	declare retorno char(40);
    set retorno = '';
    
	set disp = (select count(idLivro) from retirada where idLivro = id && dataEntrega is null);
    
     if disp = 0 then set retorno = 'Livro disponível';
		else set retorno = 'Livro indisponível';
	end if;
    
    return retorno;
end $

CREATE VIEW view_livrosDisponiveis AS
    SELECT 
        l.titulo AS Livro
    FROM
        retirada r
            INNER JOIN
        livro l ON l.id = r.idLivro
    WHERE
        livroDisponivel(l.id) = 'Livro disponível'
    GROUP BY l.titulo;
    
delimiter $
create procedure reservarLivro(in aluno int, in atendente int, in livro int, in retirada date, in previsao date)
begin insert into retirada (idAluno, idAtendente, idLivro, dataRetirada, previsaoEntrega, dataEntrega)
		values (aluno, atendente, livro, retirada, previsao, null);
end $
    
        