/** Pergunta 3 **/


/** Pergunta 4 **/

-- a)

-- Sinceramente, esta porcaria das horas não faz sentido algum. O que é que é o quê? Pisses!
select ta.tipo, sum(ta.horas_turno * ta.n_aulas * ta.turnos) -- Not sure about this
from xtiposaula_tab ta
join xucs_tab ucs
on ta.ocorrencias.codigo = ucs.codigo
where ucs.curso = 233
    and ta.ano_letivo = '2004/2005'
group by ta.tipo;


-- b)

