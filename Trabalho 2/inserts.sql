insert into xdocentes_tab (nr, nome, sigla, categoria, proprio, apelido, estado)
select nr, nome, sigla, categoria, proprio, apelido, estado
from GTD10.xdocentes;

insert into xucs_tab (codigo, designacao, sigla_uc, curso)
select codigo, designacao, sigla_uc, curso
from GTD10.xucs;

insert into xocorrencias_tab (xucs, ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento)
select ref(s), ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento
from xucs_tab s 
join GTD10.XOCORRENCIAS
on s.codigo = GTD10.xocorrencias.codigo;


-- Para testar (Depende dos create)

update xucs_tab u
set u.ocorrencias = cast(multiset(
    select oco.*
    from xocorrencias_tab oco
    where oco.xucs.codigo = u.codigo) as xocorrencias_tab_t);
/*
update xucs_tab u
set u.ocorrencias = cast(multiset(
    select ref(oco)
    from xocorrencias_tab oco
    where oco.xucs.codigo = u.codigo) as xocorrencias_tab_t);*/

insert into xtiposaula_tab (id, tipo, turnos, n_aulas, horas_turno, ocorrencias)
select id, tipo, turnos, n_aulas, horas_turno, ref(o)
from GTD10.xtiposaula
join xocorrencias_tab o
on (o.ano_letivo = GTD10.xtiposaula.ano_letivo
    and o.periodo = GTD10.xtiposaula.periodo
    and o.codigo = GTD10.xtiposaula.codigo
);

insert into xdsd_tab (horas, fator, ordem, docentes, tiposaula)
select horas, fator, ordem, tiposaula, ref(doc), cast(multiset(
    select t.*
    from xtiposaula_tab t
    join xdsd d
    where d.id = t.id) as xtiposaula_tab_t)
from GTD10.xdsd
join xdocentes_tab
on xdocentes_tab.nr = GTD10.xdsd.nr;

/*
insert into xdsd_tab (horas, fator, ordem, docentes, tiposaula)
select horas, fator, ordem, tiposaula, ref(doc), cast(multiset(
    select ref(t)
    from xtiposaula_tab t
    join xdsd d
    where d.id = t.id) as xtiposaula_tab_t)
from GTD10.xdsd
join xdocentes_tab
on xdocentes_tab.nr = GTD10.xdsd.nr;
*/