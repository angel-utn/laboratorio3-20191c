--A) El ganador del torneo es aquel que haya capturado el pez más pesado entre todos los peces siempre
--y cuando se trate de un pez no descartado. Puede haber más de un ganador del torneo. Listar Apellido y
--nombre, especie de pez que capturó y el pesaje del mismo. (10 puntos)
SELECT TOP 1 WITH TIES PA.APELLIDO, PA.NOMBRE, E.ESPECIE, PE.PESO
FROM PARTICIPANTES AS PA
INNER JOIN PESCA AS PE ON PA.IDPARTICIPANTE = PE.IDPARTICIPANTE
INNER JOIN ESPECIES AS E ON E.IDESPECIE = PE.IDESPECIE
ORDER BY PE.PESO DESC

SELECT PA.APELLIDO, PA.NOMBRE, E.ESPECIE, PE.PESO
FROM PARTICIPANTES AS PA
INNER JOIN PESCA AS PE ON PA.IDPARTICIPANTE = PE.IDPARTICIPANTE
INNER JOIN ESPECIES AS E ON E.IDESPECIE = PE.IDESPECIE
WHERE PE.PESO = (SELECT MAX(PESO) FROM PESCA WHERE IDESPECIE IS NOT NULL)

--B) Listar todos los participantes que no hayan pescado ningún tipo de bagre. (ninguna especie cuyo
--nombre contenga la palabra "bagre"). Listar apellido y nombre. (10 puntos)
SELECT APELLIDO, NOMBRE FROM PARTICIPANTES WHERE IDPARTICIPANTE NOT IN(
SELECT DISTINCT PE.IDPARTICIPANTE FROM PESCA AS PE
INNER JOIN ESPECIES AS E ON E.IDESPECIE = PE.IDESPECIE
WHERE E.ESPECIE LIKE '%BAGRE%'
)

--C) Listar los participantes cuyo promedio de pesca (en kilos) sea mayor a 30. Listar apellido, nombre y
--promedio de kilos. ATENCIÓN: No tener en cuenta los peces descartados. (10 puntos)
SELECT PA.APELLIDO, PA.NOMBRE, AVG(PE.PESO) AS PROM
FROM PARTICIPANTES AS PA
INNER JOIN PESCA AS PE ON PA.IDPARTICIPANTE = PE.IDPARTICIPANTE
WHERE PE.IDESPECIE IS NOT NULL
GROUP BY PA.APELLIDO, PA.NOMBRE
HAVING AVG(PE.PESO) > 30

--D) Por cada especie listar la cantidad de veces que han sido capturadas por un pescador durante la
--noche. (Se tiene en cuenta a la noche como el horario de la competencia entre las 21pm y las 5am
---ambas inclusive-) (20 puntos)
SELECT E.ESPECIE, COUNT(*) AS CANTNOCHE
FROM ESPECIES AS E
INNER JOIN PESCA AS PE ON PE.IDESPECIE = E.IDESPECIE
--WHERE DATEPART(HOUR, PE.FECHA_HORA) >= 21 OR
--DATEPART(HOUR, PE.FECHA_HORA) <= 5
WHERE DATEPART(HOUR, PE.FECHA_HORA) NOT BETWEEN 6 AND 20
GROUP BY E.ESPECIE

--E) Por cada participante, listar apellido, nombres, la cantidad de peces no descartados y la cantidad de
--peces descartados que capturó. (20 puntos)
SELECT PA.APELLIDO, PA.NOMBRE,
	(SELECT COUNT(*) FROM PESCA WHERE IDPARTICIPANTE = PA.IDPARTICIPANTE AND IDESPECIE IS NULL) AS CANT_DESC,
	(SELECT COUNT(*) FROM PESCA WHERE IDPARTICIPANTE = PA.IDPARTICIPANTE AND IDESPECIE IS NOT NULL) AS CANT_NODESC
FROM PARTICIPANTES AS PA