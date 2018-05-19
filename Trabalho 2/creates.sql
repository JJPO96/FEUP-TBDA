/** drops */

drop type xdsd_t force;
drop type xucs_t force;
drop type xocorrencias_t force;
drop type xocorrencias_tab_t force;
drop type xtiposaula_t force;
drop type xtiposaula_tab_t force;
drop type xdocentes_t force;
drop type xdsd_tab_t force;

drop table xocorrencias_tab;
drop table xucs_tab;
drop table xtiposaula_tab;
drop table xdsd_tab;
drop table xdocentes_tab;

/** types */

create type xucs_t as object (
   codigo           varchar2(9 byte),
   designacao       varchar2(150 byte),
   sigla_uc         varchar2(6 byte),
   curso            number(4,0));
/
create type xocorrencias_t as object (
   ucs              ref xucs_t,
   codigo           varchar2(9 byte),
   ano_letivo       varchar2(9 byte),
   periodo          varchar2(2 byte),
   inscritos        number(38,0),
   com_frequencia   number(38,0),
   aprovados        number(38,0),
   objetivos        varchar2(4000 byte),
   conteudo         varchar2(4000 byte),
   departamento     varchar2(6 byte));
/
create type xtiposaula_t as object (
    id          number(10,0),
    tipo        varchar2(2 byte),
    codigo      varchar2(9 byte),
    ano_letivo  varchar2(9 byte),
    periodo     varchar2(2 byte),
    ocorrencias ref xocorrencias_t,
    turnos      number(4,2),
    n_aulas     number,
    horas_turno number(4,2),
    map member function class_hours return number);
/
create type xdsd_t as object (
   nr           number,
   id           number(10,0),
   horas        number(4,2),
   fator        number(3,2),
   ordem        number,
   tiposaula    ref xtiposaula_t,
   map member function factor_hours return number);
/
create type xdocentes_t as object(
    nr              number,
    nome            varchar2(75 byte),
    sigla           varchar2(8 byte),
    categoria       number,
    proprio         varchar2(25 byte),
    apelido         varchar2(25 byte),
    estado          varchar2(3 byte));
/

create type xocorrencias_tab_t as table of ref xocorrencias_t;
/
create type xtiposaula_tab_t as table of ref xtiposaula_t;
/
create type xdsd_tab_t as table of ref xdsd_t;
/

alter type xucs_t ADD ATTRIBUTE ocorrencias xocorrencias_tab_t cascade;
/
alter type xocorrencias_t ADD ATTRIBUTE tiposaula xtiposaula_tab_t cascade;
/
alter type xtiposaula_t ADD ATTRIBUTE dsd xdsd_tab_t cascade;
/
alter type xdocentes_t ADD ATTRIBUTE dsd xdsd_tab_t cascade;
/
alter type xdsd_t ADD ATTRIBUTE docentes ref xdocentes_t cascade;
/


/** tables */

create table xdsd_tab of xdsd_t;
/

create table xucs_tab of xucs_t
(
    codigo primary key,
    designacao not null
)
    nested table ocorrencias store as xocorrencias_nt;
/
create table xocorrencias_tab of xocorrencias_t
(
    primary key (codigo, ano_letivo, periodo)
)
    nested table tiposaula store as xtiposaula_nt;
/
create table xtiposaula_tab of xtiposaula_t
(
    id primary key
)
    nested table dsd store as xdsd_nt;
/
create table xdocentes_tab of xdocentes_t
(
    nr primary key
)
    nested table dsd store as xdsd_nt_2;
/

/** methods */
create type body xtiposaula_t as 
    map member function class_hours return number is 
        begin 
        return turnos * horas_turno;
        end class_hours;
end;
/

create type body xdsd_t as 
    map member function factor_hours return number is 
        begin 
        return horas * fator;
        end factor_hours;
end;
/