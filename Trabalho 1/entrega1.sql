-- 1)
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
   
-- 2)

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


-- 3.a)

/* Dá 138 - o que estaria bem não fossem os dados xD*/

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
        WHERE ANO_LETIVO = '2003/2004');

/* Dá 70 */
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

-- 3.b)

/* Dá 70 */
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

-- 4)
DROP VIEW DOC_AULA;
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
            ON GROUPED_TIPO_DOC.DOC_NR = XDOCENTES.NR;

/* Acho que não está muito bem o de cima */

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

--5)
--5.a)

CREATE INDEX A ON XTIPOSAULA (ANO_LETIVO,TIPO);
DROP INDEX A;

SELECT XOCORRENCIAS.CODIGO, XOCORRENCIAS.ANO_LETIVO, XOCORRENCIAS.PERIODO, XTIPOSAULA.TURNOS * XTIPOSAULA.HORAS_TURNO AS TOTAL_HORAS
    FROM XOCORRENCIAS
        JOIN XTIPOSAULA
            ON XOCORRENCIAS.CODIGO = XTIPOSAULA.CODIGO
                AND XOCORRENCIAS.ANO_LETIVO = XTIPOSAULA.ANO_LETIVO 
    WHERE (XOCORRENCIAS.ANO_LETIVO = '2002/2003'
        OR XOCORRENCIAS.ANO_LETIVO = '2003/2004')
        AND XTIPOSAULA.TIPO = 'OT';

--5.b)
DROP INDEX B;
CREATE BITMAP INDEX B ON XTIPOSAULA (ANO_LETIVO,TIPO);

SELECT XOCORRENCIAS.CODIGO, XOCORRENCIAS.ANO_LETIVO, XOCORRENCIAS.PERIODO, XTIPOSAULA.TURNOS * XTIPOSAULA.HORAS_TURNO AS TOTAL_HORAS
    FROM XOCORRENCIAS
        JOIN XTIPOSAULA
            ON XOCORRENCIAS.CODIGO = XTIPOSAULA.CODIGO
                AND XOCORRENCIAS.ANO_LETIVO = XTIPOSAULA.ANO_LETIVO 
    WHERE (XOCORRENCIAS.ANO_LETIVO = '2002/2003'
        OR XOCORRENCIAS.ANO_LETIVO = '2003/2004')
        AND XTIPOSAULA.TIPO = 'OT';

--6)
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