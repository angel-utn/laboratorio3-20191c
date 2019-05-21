--A) Listar todas las mediciones de Argentina del día de hoy en las que se hayan registrado lluvias y temperaturas superiores a 15ºC. (10 puntos)
SET DATEFORMAT 'DMY'
Select M.* From Mediciones as M
Inner Join Sensores as S ON S.IDSENSOR = M.IDSENSOR
Inner Join Paises aS P ON P.IDPAIS = S.IDPAIS
Where M.LLUVIA > 0 and M.TEMPERATURA > 15 And P.PAIS Like 'Argentina'
and CAST(M.FECHA_HORA AS DATE) = CAST ('13/5/2019' AS DATE)


--B) La amplitud térmica es la diferencia entre la temperatura máxima y la temperatura mínima en un lugar y tiempo determinado. 
--Listar la amplitud térmica del país de Chile en Febrero de 2019. (20 puntos)
Select MAX(M.Temperatura) - MIN(M.Temperatura) AS Amplitud From Mediciones as M
Inner Join Sensores as S ON S.IDSENSOR = M.IDSENSOR
Inner Join Paises aS P ON P.IDPAIS = S.IDPAIS
Where P.PAIS = 'Chile' AND MONTH(M.Fecha_Hora) = 2 AND YEAR(M.FEcha_Hora) = 2019

--C) Listar todos los países que no hayan registrado ninguna temperatura menor a 0º en el mes de Junio de 2018. (10 puntos)
Select * from paises where idpais not in (
	Select distinct s.IDPAIS From Mediciones as M
	Inner Join SENSORES as S ON S.IDSENSOR = M.IDSENSOR
	where TEMPERATURA < 0 and month(fecha_hora) = 6 and year(fecha_hora) = 2018
)

--D) Listar para cada país, el acumulado de lluvia del mes en curso. Sólo listar un país si registró un acumulado de lluvias mayor a 50mm. (15 puntos)
Select P.Pais, SUM(lluvia) as Acumulado from Paises as P
Inner join sensores as S on P.IDPAIS = S.IDPAIS
Inner Join Mediciones as M ON M.IDSENSOR = S.IDSENSOR
Where Month(fecha_hora) = month(getdate()) and year(fecha_hora) = year(getdate())
group by P.Pais
Having Sum(lluvia) > 50

--E) Listar la cantidad de sensores distintos que registraron lluvias entre las 15 y las 18 hs. (15 puntos)
Select count(distinct idsensor) As Cantidad from mediciones where lluvia > 0 and datepart(hour, fecha_hora) between 15 and 18

