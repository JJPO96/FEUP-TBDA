/* 1º */

create type xucs_t as object (
   codigo           varchar2(9),
   designacao       varchar2(150),
   sigla_uc         varchar2(6),
   curso            number(4,0));
/

/* 2º */

create type xocorrencias_t as object (
   xucs             ref xucs_t,
   ano_letivo       varchar2(9),
   periodo          varchar2(2),
   inscritos        number(38,0),
   com_frequencia   number(38,0),
   aprovados        number(38,0),
   objetivos        varchar2(4000),
   conteudo         varchar2(4000),
   departamento     varchar2(6));
/

/* 3º */

create table xocorrencias_tab of xocorrencias_t (
    ano_letivo not null,
    periodo not null
);
/

/* 4º */

create type xocorrencias_tab_t as table of xocorrencias_t;
/

/*
create type xocorrencias_tab_t as table of ref xocorrencias_t;
/*/

/* 5º */

alter type xucs_t ADD ATTRIBUTE ocorrencias xocorrencias_tab_t cascade;
/

/* 6º */

create table xucs_tab of xucs_t(
    codigo primary key,
    designacao not null
)
    nested table ocorrencias store as xocorrencias_nt;
/

/* 7º */

create type xtiposaula_t as object (
    id          number(10,0),
    tipo        varchar2(2),
    ocorrencias ref xocorrencias_t,
    turnos      number(4,2),
    n_aulas     number,
    horas_turno number(4,2));
/

/* 8º */

create table xtiposaula_tab of xtiposaula_t (
    id primary key
);
/

/* 9º */

create type xtiposaula_tab_t as table of xtiposaula_t;
/

/*create type xtiposaula_tab_t as table of ref xtiposaula_t;
/*/

/* 10º */

alter type xocorrencias_t ADD ATTRIBUTE tiposaula xtiposaula_tab_t cascade;
/

/* 11º */

create type xdsd_t as object (
   horas    number(4,2),
   fator    number(3,2),
   ordem    number,
   tiposaula xtiposaula_tab_t);
/

/* 12º */
create table xdsd_tab of xdsd_t(
    horas not null
)
    nested TABLE tiposaula STORE as xtiposaula_nt;
/

/* 13º */

alter type xtiposaula_t ADD ATTRIBUTE dsd ref xdsd_t cascade;
/

/* 14º */

create type xdocentes_t as object(
    nr              number,
    nome            varchar2(75),
    sigla           varchar2(8),
    categoria       number,
    proprio         varchar2(25),
    apelido         varchar2(25),
    estado          varchar2(3),
    dsd             ref xdsd_t);
/

/* 15º */

create table xdocentes_tab of xdocentes_t(
    nr primary key,
    nome not null,
    sigla not null,
    estado not null
);
/

/* 16º */

alter type xdsd_t ADD ATTRIBUTE docentes ref xdocentes_t cascade;
/
