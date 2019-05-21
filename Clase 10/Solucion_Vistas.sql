--G) Hacer una vista que liste el nombre del país, número de sensor, fecha y hora y los valores de temperaturas registrados.
Create View VW_G AS
Select PA.Pais, M.IdSensor, M.Fecha_Hora, M.Temperatura
From Paises as PA
Inner Join Sensores as S ON PA.IDPAIS = S.IDPAIS
Inner Join MEDICIONES as M ON M.IDSENSOR = S.IDSENSOR

SELECT * FROM VW_G

--H) Hacer una vista que liste el nombre del país, número de sensor, fecha (sin el tiempo), hora (sin la fecha ni los minutos ni segundos), 
--temperatura, mm de lluvia y viento.
Create View VW_H AS
Select PA.Pais, M.IdSensor, Cast(M.Fecha_Hora AS DATE) AS Fecha, DatePart(Hour, M.FECHA_HORA) AS Hora, M.Temperatura, M.LLUVIA, M.VIENTO
From Paises as PA
Inner Join Sensores as S ON PA.IDPAIS = S.IDPAIS
Inner Join MEDICIONES as M ON M.IDSENSOR = S.IDSENSOR

Select * From VW_H

--I) Hacer una vista que liste por cada país, la cantidad de temperaturas registradas, la temperatura máxima, la temperatura mínima y el 
--promedio de temperaturas.
Create View VW_I
AS
Select PA.Pais, Count(*) As Cantidad, Max(Temperatura) as Maxima, Min(Temperatura) as Minima, CAST(AVG(Temperatura*1.0) AS Decimal(4,2)) AS Promedio
From Paises as PA
Inner Join Sensores as S ON PA.IDPAIS = S.IDPAIS
Inner Join MEDICIONES as M ON M.IDSENSOR = S.IDSENSOR
Group By PA.PAIS
	
Select * From VW_I

--J) Hacer una vista que liste para cada país, el nombre y la cantidad de días transcurridos desde la última vez que llovió. 
--Si no llovió no debe figurar en el listado.
Create View VW_J AS
Select Aux.Pais, Aux.Diastranscurridos FROM (
	Select PA.Pais, 
		Datediff(day,
			(
				Select MAX(fecha_hora) from Mediciones as M Inner Join Sensores as S 
				on S.IDSENSOR = M.IDSENSOR WHERE M.LLUVIA > 0 AND S.IDPAIS = PA.IDPAIS
			), getdate()
			) As Diastranscurridos
	From Paises AS PA
) As Aux
Where Aux.Diastranscurridos IS NOT NULL

Select * From VW_J