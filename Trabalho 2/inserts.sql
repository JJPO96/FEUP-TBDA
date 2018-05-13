insert into xdocentes_tab (nr, nome, sigla, categoria, proprio, apelido, estado)
select nr, nome, sigla, categoria, proprio, apelido, estado
from xdocentes;

insert into xucs_tab (codigo, designacao, sigla_uc, curso)
select codigo, designacao, sigla_uc, curso
from xucs;

insert into xocorrencias_tab (xucs, ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento)
select ref(s), ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento
from xucs_tab s 
join xocorrencias
on s.codigo = xocorrencias.codigo;