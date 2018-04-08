-- 1)
/*X*/
SELECT DISTINCT XUCS.CODIGO, DESIGNACAO, XOCORRENCIAS.ANO_LETIVO, INSCRITOS,  TIPO, TURNOS
FROM XUCS
JOIN XOCORRENCIAS
    ON XUCS.CODIGO = XOCORRENCIAS.CODIGO
JOIN XTIPOSAULA
    ON (XUCS.CODIGO = XTIPOSAULA.CODIGO
    AND XTIPOSAULA.ANO_LETIVO = XOCORRENCIAS.ANO_LETIVO
    AND XTIPOSAULA.PERIODO = XOCORRENCIAS.PERIODO)
WHERE XUCS.DESIGNACAO = 'Bases de Dados'
    AND XUCS.CURSO = 275;

/*Y*/
SELECT DISTINCT YUCS.CODIGO, DESIGNACAO,YOCORRENCIAS.ANO_LETIVO, INSCRITOS,  TIPO, TURNOS
FROM YUCS
JOIN YOCORRENCIAS
    ON YUCS.CODIGO = YOCORRENCIAS.CODIGO
JOIN YTIPOSAULA
    ON (YUCS.CODIGO = YTIPOSAULA.CODIGO
    AND YTIPOSAULA.ANO_LETIVO = YOCORRENCIAS.ANO_LETIVO
    AND YTIPOSAULA.PERIODO = YOCORRENCIAS.PERIODO)
WHERE YUCS.DESIGNACAO = 'Bases de Dados'
    AND YUCS.CURSO = 275;

/*Z*/   
SELECT DISTINCT ZUCS.CODIGO, DESIGNACAO,ZOCORRENCIAS.ANO_LETIVO, INSCRITOS,  TIPO, TURNOS
FROM ZUCS
JOIN ZOCORRENCIAS
    ON ZUCS.CODIGO = ZOCORRENCIAS.CODIGO
JOIN ZTIPOSAULA
    ON (ZUCS.CODIGO = ZTIPOSAULA.CODIGO
    AND ZTIPOSAULA.ANO_LETIVO = ZOCORRENCIAS.ANO_LETIVO
    AND ZTIPOSAULA.PERIODO = ZOCORRENCIAS.PERIODO)
WHERE ZUCS.DESIGNACAO = 'Bases de Dados'
    AND ZUCS.CURSO = 275;
   
-- 2)
/*X*/
SELECT TIPO, SUM(HORAS_TURNO * TURNOS) 
FROM XTIPOSAULA
JOIN XOCORRENCIAS
    ON (XOCORRENCIAS.CODIGO = XTIPOSAULA.CODIGO
    AND XOCORRENCIAS.ANO_LETIVO = XTIPOSAULA.ANO_LETIVO
    AND XOCORRENCIAS.PERIODO = XTIPOSAULA.PERIODO)
JOIN XUCS 
    ON XTIPOSAULA.CODIGO = XUCS.CODIGO
WHERE XTIPOSAULA.ANO_LETIVO = '2004/2005'
    AND XUCS.CURSO = 233
GROUP BY TIPO;

/*Y*/
SELECT TIPO, SUM(HORAS_TURNO * TURNOS) 
FROM YTIPOSAULA
JOIN YOCORRENCIAS
    ON (YOCORRENCIAS.CODIGO = YTIPOSAULA.CODIGO
    AND YOCORRENCIAS.ANO_LETIVO = YTIPOSAULA.ANO_LETIVO
    AND YOCORRENCIAS.PERIODO = YTIPOSAULA.PERIODO)
JOIN YUCS 
    ON YTIPOSAULA.CODIGO = YUCS.CODIGO
WHERE YTIPOSAULA.ANO_LETIVO = '2004/2005'
    AND YUCS.CURSO = 233
GROUP BY TIPO;

/*Z*/
SELECT TIPO, SUM(HORAS_TURNO * TURNOS) 
FROM ZTIPOSAULA
JOIN ZOCORRENCIAS
    ON (ZOCORRENCIAS.CODIGO = ZTIPOSAULA.CODIGO
    AND ZOCORRENCIAS.ANO_LETIVO = ZTIPOSAULA.ANO_LETIVO
    AND ZOCORRENCIAS.PERIODO = ZTIPOSAULA.PERIODO)
JOIN ZUCS 
    ON ZTIPOSAULA.CODIGO = ZUCS.CODIGO
WHERE ZTIPOSAULA.ANO_LETIVO = '2004/2005'
    AND ZUCS.CURSO = 233
GROUP BY TIPO;

-- 3.a)

/* Dá 138 - o que estaria bem não fossem os dados xD*/
/*
SELECT DISTINCT XUCS.CODIGO
FROM XUCS 
JOIN XOCORRENCIAS
ON XOCORRENCIAS.CODIGO = XUCS.CODIGO
WHERE ANO_LETIVO = '2003/2004'
    AND XUCS.CODIGO NOT IN
        (SELECT DISTINCT CODIGO
        FROM XTIPOSAULA
        JOIN XDSD
        ON XTIPOSAULA.ID = XDSD.ID
        WHERE ANO_LETIVO = '2003/2004');*/

/* Dá 70 */
/*X*/
SELECT DISTINCT XUCS.CODIGO
FROM XUCS
JOIN XOCORRENCIAS 
    ON XOCORRENCIAS.CODIGO = XUCS.CODIGO
JOIN XTIPOSAULA
    ON (XTIPOSAULA.CODIGO = XOCORRENCIAS.CODIGO 
    AND XTIPOSAULA.ANO_LETIVO = XOCORRENCIAS.ANO_LETIVO
    AND XTIPOSAULA.PERIODO = XOCORRENCIAS.PERIODO)
WHERE XOCORRENCIAS.ANO_LETIVO = '2003/2004'
    AND XTIPOSAULA.ID 
        NOT IN (SELECT XDSD.ID 
                FROM XDSD
                JOIN XTIPOSAULA 
                    ON XDSD.ID = XTIPOSAULA.ID
                    WHERE XTIPOSAULA.ANO_LETIVO = '2003/2004');

/*Y*/
SELECT DISTINCT YUCS.CODIGO
FROM YUCS
JOIN YOCORRENCIAS 
    ON YOCORRENCIAS.CODIGO = YUCS.CODIGO
JOIN YTIPOSAULA
    ON (YTIPOSAULA.CODIGO = YOCORRENCIAS.CODIGO 
    AND YTIPOSAULA.ANO_LETIVO = YOCORRENCIAS.ANO_LETIVO
    AND YTIPOSAULA.PERIODO = YOCORRENCIAS.PERIODO)
WHERE YOCORRENCIAS.ANO_LETIVO = '2003/2004'
    AND YTIPOSAULA.ID 
        NOT IN (SELECT YDSD.ID 
                FROM YDSD
                JOIN YTIPOSAULA 
                    ON YDSD.ID = YTIPOSAULA.ID
                    WHERE YTIPOSAULA.ANO_LETIVO = '2003/2004');

/*Z*/                   
SELECT DISTINCT ZUCS.CODIGO
FROM ZUCS
JOIN ZOCORRENCIAS 
    ON ZOCORRENCIAS.CODIGO = ZUCS.CODIGO
JOIN ZTIPOSAULA
    ON (ZTIPOSAULA.CODIGO = ZOCORRENCIAS.CODIGO 
    AND ZTIPOSAULA.ANO_LETIVO = ZOCORRENCIAS.ANO_LETIVO
    AND ZTIPOSAULA.PERIODO = ZOCORRENCIAS.PERIODO)
WHERE ZOCORRENCIAS.ANO_LETIVO = '2003/2004'
    AND ZTIPOSAULA.ID 
        NOT IN (SELECT ZDSD.ID 
                FROM ZDSD
                JOIN ZTIPOSAULA 
                    ON ZDSD.ID = ZTIPOSAULA.ID
                    WHERE ZTIPOSAULA.ANO_LETIVO = '2003/2004');

-- 3.b)

/* Dá 70 */

/*X*/
SELECT DISTINCT XUCS.CODIGO
FROM XUCS
JOIN XOCORRENCIAS
    ON XOCORRENCIAS.CODIGO = XUCS.CODIGO
JOIN XTIPOSAULA
    ON (XOCORRENCIAS.CODIGO = XTIPOSAULA.CODIGO
    AND XOCORRENCIAS.ANO_LETIVO = XTIPOSAULA.ANO_LETIVO
    AND XOCORRENCIAS.PERIODO = XTIPOSAULA.PERIODO)
LEFT JOIN XDSD
    ON XDSD.ID = XTIPOSAULA.ID
WHERE XOCORRENCIAS.ANO_LETIVO = '2003/2004'
    AND XDSD.ID IS NULL
ORDER BY CODIGO ASC;

/*Y*/
SELECT DISTINCT YUCS.CODIGO
FROM YUCS
JOIN YOCORRENCIAS
    ON YOCORRENCIAS.CODIGO = YUCS.CODIGO
JOIN YTIPOSAULA
    ON (YOCORRENCIAS.CODIGO = YTIPOSAULA.CODIGO
    AND YOCORRENCIAS.ANO_LETIVO = YTIPOSAULA.ANO_LETIVO
    AND YOCORRENCIAS.PERIODO = YTIPOSAULA.PERIODO)
LEFT JOIN YDSD
    ON YDSD.ID = YTIPOSAULA.ID
WHERE YOCORRENCIAS.ANO_LETIVO = '2003/2004'
    AND YDSD.ID IS NULL
ORDER BY CODIGO ASC;

/*Z*/
SELECT DISTINCT ZUCS.CODIGO
FROM ZUCS
JOIN ZOCORRENCIAS
    ON ZOCORRENCIAS.CODIGO = ZUCS.CODIGO
JOIN ZTIPOSAULA
    ON (ZOCORRENCIAS.CODIGO = ZTIPOSAULA.CODIGO
    AND ZOCORRENCIAS.ANO_LETIVO = ZTIPOSAULA.ANO_LETIVO
    AND ZOCORRENCIAS.PERIODO = ZTIPOSAULA.PERIODO)
LEFT JOIN ZDSD
    ON ZDSD.ID = ZTIPOSAULA.ID
WHERE ZOCORRENCIAS.ANO_LETIVO = '2003/2004'
    AND ZDSD.ID IS NULL
ORDER BY CODIGO ASC;

-- 4)
/*DROP VIEW DOC_AULA;
CREATE VIEW DOC_AULA AS
SELECT XDOCENTES.NR AS NR, XDOCENTES.NOME AS NOME, XTIPOSAULA.TIPO AS TIPO
    FROM XDOCENTES
        JOIN XDSD
            ON XDSD.NR = XDOCENTES.NR
        JOIN XTIPOSAULA
            ON XDSD.ID = XTIPOSAULA.ID
    WHERE XTIPOSAULA.ANO_LETIVO = '2003/2004'
    ORDER BY XDOCENTES.NR;

DROP VIEW AULA_ID_HORAS;
CREATE VIEW AULA_ID_HORAS AS
SELECT ID, NR AS DOC_NR, SUM(HORAS * FATOR) AS HORAS
    FROM XDSD
    GROUP BY ID, NR;

SELECT * FROM AULA_ID_HORAS;

DROP VIEW GROUPED_TIPO_DOC;
CREATE VIEW GROUPED_TIPO_DOC AS
SELECT NR AS DOC_NR, TIPO, SUM(HORAS) AS TOTAL_HORAS
    FROM DOC_AULA
    JOIN AULA_ID_HORAS
        ON DOC_AULA.NR = AULA_ID_HORAS.DOC_NR
    GROUP BY NR, TIPO;

DROP VIEW MAX_HORAS;
CREATE VIEW MAX_HORAS AS
SELECT TIPO, MAX(TOTAL_HORAS) AS MAX_HORAS
    FROM GROUPED_TIPO_DOC
    GROUP BY TIPO;

DROP VIEW FATOR_AULA;
CREATE VIEW FATOR_AULA AS
SELECT AULA_ID_HORAS.*, XDSD.FATOR, TIPO
    FROM AULA_ID_HORAS
        JOIN XDSD
            ON XDSD.NR = AULA_ID_HORAS.DOC_NR
            AND XDSD.ID = AULA_ID_HORAS.ID
        JOIN XTIPOSAULA
            ON XTIPOSAULA.ID = AULA_ID_HORAS.ID;

SELECT NR, XDOCENTES.NOME, MAX_HORAS.TIPO, MAX_HORAS
   FROM GROUPED_TIPO_DOC
        JOIN MAX_HORAS
            ON (GROUPED_TIPO_DOC.TIPO = MAX_HORAS.TIPO
                AND GROUPED_TIPO_DOC.TOTAL_HORAS = MAX_HORAS.MAX_HORAS)
        JOIN XDOCENTES
            ON GROUPED_TIPO_DOC.DOC_NR = XDOCENTES.NR;*/

/* Acho que não está muito bem o de cima */

/*X*/
CREATE OR REPLACE VIEW SOMA_HORAS_PROFESSOR_TIPO AS
SELECT XDOCENTES.NR, NOME, TIPO, SUM(HORAS * FATOR) AS SOMA
FROM XDOCENTES
JOIN XDSD
    ON XDSD.NR = XDOCENTES.NR
JOIN XTIPOSAULA
    ON XTIPOSAULA.ID = XDSD.ID
WHERE XTIPOSAULA.ANO_LETIVO = '2003/2004'
GROUP BY XDOCENTES.NR, NOME, TIPO;

CREATE OR REPLACE VIEW MAX_HORAS_TIPO AS
SELECT TIPO, MAX(SOMA) AS MAXIMO
FROM SOMA_HORAS_PROFESSOR_TIPO
GROUP BY TIPO;

SELECT NR, NOME, MAX_HORAS_TIPO.TIPO, MAX_HORAS_TIPO.MAXIMO AS TOTAL_HORAS
FROM SOMA_HORAS_PROFESSOR_TIPO
JOIN MAX_HORAS_TIPO
    ON (MAX_HORAS_TIPO.TIPO = SOMA_HORAS_PROFESSOR_TIPO.TIPO
    AND MAX_HORAS_TIPO.MAXIMO = SOMA_HORAS_PROFESSOR_TIPO.SOMA);

/*Y*/   
CREATE OR REPLACE VIEW SOMA_HORAS_PROFESSOR_TIPO AS
SELECT YDOCENTES.NR, NOME, TIPO, SUM(HORAS * FATOR) AS SOMA
FROM YDOCENTES
JOIN YDSD
    ON YDSD.NR = YDOCENTES.NR
JOIN YTIPOSAULA
    ON YTIPOSAULA.ID = YDSD.ID
WHERE YTIPOSAULA.ANO_LETIVO = '2003/2004'
GROUP BY YDOCENTES.NR, NOME, TIPO;

CREATE OR REPLACE VIEW MAX_HORAS_TIPO AS
SELECT TIPO, MAX(SOMA) AS MAXIMO
FROM SOMA_HORAS_PROFESSOR_TIPO
GROUP BY TIPO;

SELECT NR, NOME, MAX_HORAS_TIPO.TIPO, MAX_HORAS_TIPO.MAXIMO AS TOTAL_HORAS
FROM SOMA_HORAS_PROFESSOR_TIPO
JOIN MAX_HORAS_TIPO
    ON (MAX_HORAS_TIPO.TIPO = SOMA_HORAS_PROFESSOR_TIPO.TIPO
    AND MAX_HORAS_TIPO.MAXIMO = SOMA_HORAS_PROFESSOR_TIPO.SOMA);

/*Z*/
CREATE OR REPLACE VIEW SOMA_HORAS_PROFESSOR_TIPO AS
SELECT ZDOCENTES.NR, NOME, TIPO, SUM(HORAS * FATOR) AS SOMA
FROM ZDOCENTES
JOIN ZDSD
    ON ZDSD.NR = ZDOCENTES.NR
JOIN ZTIPOSAULA
    ON ZTIPOSAULA.ID = ZDSD.ID
WHERE ZTIPOSAULA.ANO_LETIVO = '2003/2004'
GROUP BY ZDOCENTES.NR, NOME, TIPO;

CREATE OR REPLACE VIEW MAX_HORAS_TIPO AS
SELECT TIPO, MAX(SOMA) AS MAXIMO
FROM SOMA_HORAS_PROFESSOR_TIPO
GROUP BY TIPO;

SELECT NR, NOME, MAX_HORAS_TIPO.TIPO, MAX_HORAS_TIPO.MAXIMO AS TOTAL_HORAS
FROM SOMA_HORAS_PROFESSOR_TIPO
JOIN MAX_HORAS_TIPO
    ON (MAX_HORAS_TIPO.TIPO = SOMA_HORAS_PROFESSOR_TIPO.TIPO
    AND MAX_HORAS_TIPO.MAXIMO = SOMA_HORAS_PROFESSOR_TIPO.SOMA);
--5)
--5.a)

/*X*/
DROP INDEX AX;
CREATE INDEX AX ON XTIPOSAULA (ANO_LETIVO,TIPO);

SELECT XOCORRENCIAS.CODIGO, XOCORRENCIAS.ANO_LETIVO, XOCORRENCIAS.PERIODO, XTIPOSAULA.TURNOS * XTIPOSAULA.HORAS_TURNO AS TOTAL_HORAS
    FROM XOCORRENCIAS
        JOIN XTIPOSAULA
            ON XOCORRENCIAS.CODIGO = XTIPOSAULA.CODIGO
                AND XOCORRENCIAS.ANO_LETIVO = XTIPOSAULA.ANO_LETIVO 
    WHERE (XOCORRENCIAS.ANO_LETIVO = '2002/2003'
        OR XOCORRENCIAS.ANO_LETIVO = '2003/2004')
        AND XTIPOSAULA.TIPO = 'OT';
        
/*Y*/
DROP INDEX AY;
CREATE INDEX AY ON YTIPOSAULA (ANO_LETIVO,TIPO);

SELECT YOCORRENCIAS.CODIGO, YOCORRENCIAS.ANO_LETIVO, YOCORRENCIAS.PERIODO, YTIPOSAULA.TURNOS * YTIPOSAULA.HORAS_TURNO AS TOTAL_HORAS
    FROM YOCORRENCIAS
        JOIN YTIPOSAULA
            ON YOCORRENCIAS.CODIGO = YTIPOSAULA.CODIGO
                AND YOCORRENCIAS.ANO_LETIVO = YTIPOSAULA.ANO_LETIVO 
    WHERE (YOCORRENCIAS.ANO_LETIVO = '2002/2003'
        OR YOCORRENCIAS.ANO_LETIVO = '2003/2004')
        AND YTIPOSAULA.TIPO = 'OT';
        
/*Z*/
DROP INDEX AZ;
CREATE INDEX AZ ON ZTIPOSAULA (ANO_LETIVO,TIPO);

SELECT ZOCORRENCIAS.CODIGO, ZOCORRENCIAS.ANO_LETIVO, ZOCORRENCIAS.PERIODO, ZTIPOSAULA.TURNOS * ZTIPOSAULA.HORAS_TURNO AS TOTAL_HORAS
    FROM ZOCORRENCIAS
        JOIN ZTIPOSAULA
            ON ZOCORRENCIAS.CODIGO = ZTIPOSAULA.CODIGO
                AND ZOCORRENCIAS.ANO_LETIVO = ZTIPOSAULA.ANO_LETIVO 
    WHERE (ZOCORRENCIAS.ANO_LETIVO = '2002/2003'
        OR ZOCORRENCIAS.ANO_LETIVO = '2003/2004')
        AND ZTIPOSAULA.TIPO = 'OT';
--5.b)
/*X*/
DROP INDEX BX;
CREATE BITMAP INDEX BX ON XTIPOSAULA (ANO_LETIVO,TIPO);

SELECT XOCORRENCIAS.CODIGO, XOCORRENCIAS.ANO_LETIVO, XOCORRENCIAS.PERIODO, XTIPOSAULA.TURNOS * XTIPOSAULA.HORAS_TURNO AS TOTAL_HORAS
    FROM XOCORRENCIAS
        JOIN XTIPOSAULA
            ON XOCORRENCIAS.CODIGO = XTIPOSAULA.CODIGO
                AND XOCORRENCIAS.ANO_LETIVO = XTIPOSAULA.ANO_LETIVO 
    WHERE (XOCORRENCIAS.ANO_LETIVO = '2002/2003'
        OR XOCORRENCIAS.ANO_LETIVO = '2003/2004')
        AND XTIPOSAULA.TIPO = 'OT';
        
/*Y*/
DROP INDEX B;
CREATE BITMAP INDEX B ON YTIPOSAULA (ANO_LETIVO,TIPO);

SELECT YOCORRENCIAS.CODIGO, YOCORRENCIAS.ANO_LETIVO, YOCORRENCIAS.PERIODO, YTIPOSAULA.TURNOS * YTIPOSAULA.HORAS_TURNO AS TOTAL_HORAS
    FROM YOCORRENCIAS
        JOIN YTIPOSAULA
            ON YOCORRENCIAS.CODIGO = YTIPOSAULA.CODIGO
                AND YOCORRENCIAS.ANO_LETIVO = YTIPOSAULA.ANO_LETIVO 
    WHERE (YOCORRENCIAS.ANO_LETIVO = '2002/2003'
        OR YOCORRENCIAS.ANO_LETIVO = '2003/2004')
        AND YTIPOSAULA.TIPO = 'OT';
        
/*Z*/
DROP INDEX BZ;
CREATE BITMAP INDEX BZ ON ZTIPOSAULA (ANO_LETIVO,TIPO);

SELECT ZOCORRENCIAS.CODIGO, ZOCORRENCIAS.ANO_LETIVO, ZOCORRENCIAS.PERIODO, ZTIPOSAULA.TURNOS * ZTIPOSAULA.HORAS_TURNO AS TOTAL_HORAS
    FROM ZOCORRENCIAS
        JOIN ZTIPOSAULA
            ON ZOCORRENCIAS.CODIGO = ZTIPOSAULA.CODIGO
                AND ZOCORRENCIAS.ANO_LETIVO = ZTIPOSAULA.ANO_LETIVO 
    WHERE (ZOCORRENCIAS.ANO_LETIVO = '2002/2003'
        OR ZOCORRENCIAS.ANO_LETIVO = '2003/2004')
        AND ZTIPOSAULA.TIPO = 'OT';

--6)
/*X*/
SELECT DISTINCT XUCS.CURSO
    FROM XUCS
    WHERE 
        (EXISTS(
            SELECT XTIPOSAULA.ID 
            FROM XTIPOSAULA 
            WHERE XTIPOSAULA.TIPO='P' 
                AND XUCS.CODIGO=XTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT XTIPOSAULA.ID 
            FROM XTIPOSAULA 
            WHERE XTIPOSAULA.TIPO='TP' 
                AND XUCS.CODIGO=XTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT XTIPOSAULA.ID 
            FROM XTIPOSAULA 
            WHERE XTIPOSAULA.TIPO='T' 
                AND XUCS.CODIGO=XTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT XTIPOSAULA.ID 
            FROM XTIPOSAULA 
            WHERE XTIPOSAULA.TIPO='L' 
                AND XUCS.CODIGO=XTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT XTIPOSAULA.ID 
            FROM XTIPOSAULA 
            WHERE XTIPOSAULA.TIPO='OT' 
                AND XUCS.CODIGO=XTIPOSAULA.CODIGO)
        );
        
/*Y*/
SELECT DISTINCT YUCS.CURSO
    FROM YUCS
    WHERE 
        (EXISTS(
            SELECT YTIPOSAULA.ID 
            FROM YTIPOSAULA 
            WHERE YTIPOSAULA.TIPO='P' 
                AND YUCS.CODIGO=YTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT YTIPOSAULA.ID 
            FROM YTIPOSAULA 
            WHERE YTIPOSAULA.TIPO='TP' 
                AND YUCS.CODIGO=YTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT YTIPOSAULA.ID 
            FROM YTIPOSAULA 
            WHERE YTIPOSAULA.TIPO='T' 
                AND YUCS.CODIGO=YTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT YTIPOSAULA.ID 
            FROM YTIPOSAULA 
            WHERE YTIPOSAULA.TIPO='L' 
                AND YUCS.CODIGO=YTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT YTIPOSAULA.ID 
            FROM YTIPOSAULA 
            WHERE YTIPOSAULA.TIPO='OT' 
                AND YUCS.CODIGO=YTIPOSAULA.CODIGO)
        );
        
/*Z*/
SELECT DISTINCT ZUCS.CURSO
    FROM ZUCS
    WHERE 
        (EXISTS(
            SELECT ZTIPOSAULA.ID 
            FROM ZTIPOSAULA 
            WHERE ZTIPOSAULA.TIPO='P' 
                AND ZUCS.CODIGO=ZTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT ZTIPOSAULA.ID 
            FROM ZTIPOSAULA 
            WHERE ZTIPOSAULA.TIPO='TP' 
                AND ZUCS.CODIGO=ZTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT ZTIPOSAULA.ID 
            FROM ZTIPOSAULA 
            WHERE ZTIPOSAULA.TIPO='T' 
                AND ZUCS.CODIGO=ZTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT ZTIPOSAULA.ID 
            FROM ZTIPOSAULA 
            WHERE ZTIPOSAULA.TIPO='L' 
                AND ZUCS.CODIGO=ZTIPOSAULA.CODIGO)
        AND EXISTS(
            SELECT ZTIPOSAULA.ID 
            FROM ZTIPOSAULA 
            WHERE ZTIPOSAULA.TIPO='OT' 
                AND ZUCS.CODIGO=ZTIPOSAULA.CODIGO)
        );