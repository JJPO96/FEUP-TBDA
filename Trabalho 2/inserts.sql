/** XDOCENTES */

insert into xdocentes_tab (nr, nome, sigla, categoria, proprio, apelido, estado)
select nr, nome, sigla, categoria, proprio, apelido, estado
from xdocentes;

/** BALIZA */