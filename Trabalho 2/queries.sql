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
select d.docentes.nr, d.docentes.nome, d.tiposaula.tipo/*, sum(d.horas * d.fator) as total_assigned_hours*/
from xdsd_tab d 
where d.tiposaula.ano_letivo = '2003/2004';


-- d)

-- e)

select d.tiposaula.periodo, d.tiposaula.ano_letivo, sum(d.horas)
from xdsd_tab d
where d.tiposaula.periodo like '%S'
group by (d.tiposaula.periodo, d.tiposaula.ano_letivo);