-- inserts
insert into xucs_tab (codigo, designacao, sigla_uc, curso)
select codigo, designacao, sigla_uc, curso
from GTD10.xucs;

insert into xocorrencias_tab (ucs, codigo, ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento)
select ref(s), s.codigo, ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento
from xucs_tab s 
join GTD10.XOCORRENCIAS
on s.codigo = GTD10.xocorrencias.codigo;

insert into xtiposaula_tab (id, tipo, codigo, ano_letivo, periodo, turnos, n_aulas, horas_turno, ocorrencias)
select id, tipo, o.codigo, o.ano_letivo, o.periodo, turnos, n_aulas, horas_turno, ref(o)
from GTD10.xtiposaula
join xocorrencias_tab o
on (o.ano_letivo = GTD10.xtiposaula.ano_letivo
    and o.periodo = GTD10.xtiposaula.periodo
    and o.codigo = GTD10.xtiposaula.codigo
);

insert into xdsd_tab (id, nr, horas, fator, ordem, tiposaula)
select t.id, nr, horas, fator, ordem, ref(t)
from gtd10.xdsd
join xtiposaula_tab t
on gtd10.xdsd.id = t.id;

insert into xdocentes_tab (nr, nome, sigla, categoria, proprio, apelido, estado)
select nr, nome, sigla, categoria, proprio, apelido, estado
from gtd10.xdocentes;

-- updates
update xucs_tab u
set u.ocorrencias = cast(multiset(
    select ref(oco)
    from xocorrencias_tab oco
    where oco.codigo = u.codigo) as xocorrencias_tab_t);

update xocorrencias_tab o
set o.tiposaula = cast(multiset(
    select ref(t)
    from xtiposaula_tab t
    where o.ano_letivo = t.ano_letivo
    and o.periodo = t.periodo
    and o.codigo = t.codigo) as xtiposaula_tab_t);

update xtiposaula_tab t
set t.dsd = cast(multiset(
    select ref(d)
    from xdsd_tab d
    where d.id = t.id) as xdsd_tab_t);

update xdsd_tab d
set d.docentes = (select ref(doc)
    from xdocentes_tab doc
    where doc.nr = d.nr); 

update xdocentes_tab t
set t.dsd = cast(multiset(
    select ref(d)
    from xdsd_tab d
    where d.nr = t.nr) as xdsd_tab_t);

