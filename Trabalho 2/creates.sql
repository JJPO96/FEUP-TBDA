/* 1º */

CREATE TYPE xucs_t AS OBJECT (
   codigo           VARCHAR2(9),
   designacao       VARCHAR2(150),
   sigla_uc         VARCHAR2(6),
   curso            NUMBER(4,0));
/

/* 2º */

CREATE TYPE xocorrencias_t AS OBJECT (
   xucs             REF xucs_t,
   ano_letivo       VARCHAR2(9),
   periodo          VARCHAR2(2),
   inscritos        NUMBER(38,0),
   com_frequencia   NUMBER(38,0),
   aprovados        NUMBER(38,0),
   objetivos        VARCHAR2(4000),
   conteudo         VARCHAR2(4000),
   departamento     VARCHAR2(6));
/

/* 3º */

CREATE TABLE xocorrencias_tab OF xocorrencias_t;
/

/* 4º */

CREATE TYPE xocorrencias_tab_t AS TABLE OF xocorrencias_t;
/

/* 5º */

ALTER TYPE xucs_t ADD ATTRIBUTE ocorrencias xocorrencias_tab_t cascade;
/

/* 6º */

CREATE TABLE xucs_tab OF xucs_t
(codigo PRIMARY KEY)
    NESTED table ocorrencias store AS xocorrencias_nt;
/

/* 7º */

CREATE TYPE xtiposaula_t AS OBJECT (
    id          NUMBER(10,0),
    tipo        VARCHAR2(2),
    ocorrencias REF xocorrencias_t,
    turnos      NUMBER(4,2),
    n_aulas     NUMBER,
    horas_turno NUMBER(4,2));
/

/* 8º */

CREATE TABLE xtiposaula_tab OF xtiposaula_t;

/* 9º */

CREATE TYPE xtiposaula_tab_t AS TABLE OF xtiposaula_t;
/

/* 10º */

ALTER TYPE xocorrencias_t ADD ATTRIBUTE tiposaula xtiposaula_tab_t CASCADE;
/

/* 11º */

CREATE TYPE xdsd_t AS OBJECT (
   horas    NUMBER(4,2),
   fator    NUMBER(3,2),
   ordem    NUMBER,
   tiposaula xtiposaula_tab_t);
/

/* 12º */
CREATE TABLE xdsd_tab OF xdsd_t
    NESTED TABLE tiposaula STORE AS xtiposaula_nt;
/

/* 13º */

ALTER TYPE xtiposaula_t ADD ATTRIBUTE dsd REF xdsd_t CASCADE;
/

/* 14º */

CREATE TYPE xdocentes_t AS OBJECT(
    nr              NUMBER,
    nome            VARCHAR2(75),
    sigla           VARCHAR2(8),
    categoria       NUMBER,
    proprio         VARCHAR2(25),
    apelido         VARCHAR2(25),
    estado          VARCHAR2(3),
    dsd             ref xdsd_t);
/

/* 15º */

CREATE TABLE xdocentes_tab OF xdocentes_t;
/

/* 16º */

ALTER TYPE xdsd_t ADD ATTRIBUTE docentes REF xdocentes_t CASCADE;
/
