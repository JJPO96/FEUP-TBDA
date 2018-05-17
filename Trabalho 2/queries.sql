/** Pergunta 3 **/


/** Pergunta 4 **/

-- a)

select ta.tipo, sum(ta.horas_turno * ta.turnos) as class_hours
from xtiposaula_tab ta
where ta.ocorrencias.ucs.curso = 233
    and ta.ano_letivo = '2004/2005'
group by ta.tipo;

-- b)

select d.tiposaula.codigo, sum(d.tiposaula.horas_turno * d.tiposaula.turnos) as total_required_class_hours, sum(d.horas) as total_assigned_hours
from xdsd_tab d
where d.tiposaula.ano_letivo = '2003/2004'
group by (d.tiposaula.codigo)
having sum(d.tiposaula.horas_turno * d.tiposaula.turnos) <> sum(d.horas);

-- c)
create or replace view sum_teacher_hours as
select distinct d.docentes.nr as nr , d.docentes.nome as nome, d.tiposaula.tipo as tipoaula, sum(d.horas * d.fator) as total_hours
from xdsd_tab d 
where d.tiposaula.ano_letivo = '2003/2004'
group by (d.docentes.nr, d.docentes.nome,d.tiposaula.tipo);

create or replace view max_hours as
select tipoaula, max(total_hours)as max_teacher
from sum_teacher_hours
group by tipoaula;

select nr, nome, tipoaula, max_teacher
from sum_teacher_hours
join max_hours
on sum_teacher_hours.tipoaula=max_hours.tipoaula
and sum_teacher_hours.total_hours=max_hours.max_teacher;

-- d)

-- Para confirmar
-- select d.docentes.nome as professor, d.tiposaula.ano_letivo as ano_letivo, d.docentes.categoria as categoria, round(avg(d.horas), 2) as average_number_hours
-- from xdsd_tab d
-- where regexp_like (d.tiposaula.ano_letivo, '^200[1-4]')
-- group by d.docentes.nome, d.docentes.categoria, d.tiposaula.ano_letivo;

-- e)
/*smurf*/
select o.ucs.curso, o.periodo, o.ano_letivo, coalesce(sum(o.tiposaula.n_aulas * o.tiposaula.horas_turno),0)
from xocorrencias_tab o
where o.periodo like '%S' and (o.tiposaula.n_aulas is not null or o.tiposaula.horas_turno is not null)
group by o.ucs.curso, o.periodo, o.ano_letivo;

select d.tiposaula.periodo, d.tiposaula.ano_letivo, sum(d.horas)
from xdsd_tab d
where d.tiposaula.periodo like '%S'
group by (d.tiposaula.periodo, d.tiposaula.ano_letivo);