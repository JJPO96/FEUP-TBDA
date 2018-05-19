/** Pergunta 3 **/


/** Pergunta 4 **/

-- a)
select ta.tipo, sum(ta.class_hours())
from xtiposaula_tab ta
where ta.ocorrencias.ucs.curso = 233
    and ta.ano_letivo = '2004/2005'
group by ta.tipo;

-- b)
create or replace view required_hours as
select t.codigo as code, sum(t.class_hours()) as total_class_hours_required
from xtiposaula_tab t
where t.ano_letivo = '2003/2004'
group by t.codigo;

create or replace view assign_hours as
select d.tiposaula.codigo as code, sum(d.horas) as total_assigned_hours
from xdsd_tab d
where d.tiposaula.ano_letivo = '2003/2004'
group by d.tiposaula.codigo;

select required_hours.code, total_class_hours_required, total_assigned_hours
from required_hours, assign_hours
where required_hours.code = assign_hours.code and total_class_hours_required <> total_assigned_hours;


-- c)
create or replace view hours as
select distinct d.docentes.nr as nr , d.docentes.nome as nome, d.tiposaula.tipo as tipoaula, sum(d.factor_hours()) as total_class_hours_times_factor,
rank() over
(partition by d.tiposaula.tipo order by sum(d.horas) desc) as rank
from xdsd_tab d
where d.tiposaula.ano_letivo = '2003/2004'
group by (d.docentes.nr, d.docentes.nome,d.tiposaula.tipo);

select nr,nome, tipoaula, total_class_hours_times_factor
from hours
where rank=1;

-- d)

select d.tiposaula.ano_letivo as ano_letivo, d.docentes.categoria as categoria, round(avg(d.horas), 2) as average_number_hours
from xdsd_tab d
where regexp_like (d.tiposaula.ano_letivo, '^200[1-4]')
group by d.docentes.categoria, d.tiposaula.ano_letivo;

-- e)
select value(t).ano_letivo as ano_letivo, value(t).periodo as semester, sum(value(t).horas_turno) as total_hours_week
from xucs_tab u, table(u.ocorrencias) o, table(value(o).tiposaula) t
where value(t).periodo like '%S' and value(t).class_hours() is not null
group by value(t).ano_letivo, value(t).periodo;


-- f)
select doc.nome, value(d).tiposaula.ocorrencias.ucs.designacao
from xdocentes_tab doc, table(doc.dsd) d
where regexp_like (doc.nome,  '^Abel.') and value(d).tiposaula.ano_letivo = '2003/2004';
