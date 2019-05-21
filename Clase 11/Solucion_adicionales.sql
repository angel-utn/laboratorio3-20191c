--A) - Para cada país listar el nombre del país y la cantidad de mediciones donde se registraron lluvias y 
--la cantidad de mediciones donde no se registraron lluvias.
Select PA.Pais, 
	(
		Select Count(*) From Mediciones as M Inner Join SENSORES AS S ON M.IDSENSOR = S.IDSENSOR
		Where S.IDPAIS = PA.IDPAIS And M.LLUVIA > 0
	) AS CantLluvia, 
	(
		Select Count(*) From Mediciones as M Inner Join SENSORES AS S ON M.IDSENSOR = S.IDSENSOR
		Where S.IDPAIS = PA.IDPAIS And M.LLUVIA = 0
	) AS CantNoLluvia
From Paises AS PA

--B) - Para cada país listar el nombre del país y la temperatura máxima histórica registrada.
Select PA.Pais, MAX(M.Temperatura) as Maximo From Paises as PA
Inner Join Sensores as S ON S.IDPAIS = PA.IDPAIS
Inner Join Mediciones aS M ON M.IDSENSOR = S.IDSENSOR
Group by PA.Pais

--C) - Para cada país, listar el nombre y la cantidad de días transcurridos desde la última vez que llovió.
Select PA.Pais, 
	Datediff(day,
		(
			Select MAX(fecha_hora) from Mediciones as M Inner Join Sensores as S 
			on S.IDSENSOR = M.IDSENSOR WHERE M.LLUVIA > 0 AND S.IDPAIS = PA.IDPAIS
		), getdate()
		) As Diastranscurridos
From Paises AS PA

--D) - Por cada año, listar el promedio de temperatura.
Select Year(fecha_hora) AS Año, AVG(temperatura) as Promedio from MEDICIONES
group by Year(fecha_hora)

--E) - Listar los nombres de todos los países que hayan registrado más mediciones sin lluvia que mediciones donde 
-- llovió pero que al menos haya registrado alguna medición donde llovió.
SELECT Aux.Pais FROM (
	Select PA.Pais, 
		(
			Select Count(*) From Mediciones as M Inner Join SENSORES AS S ON M.IDSENSOR = S.IDSENSOR
			Where S.IDPAIS = PA.IDPAIS And M.LLUVIA > 0
		) AS CantLluvia, 
		(
			Select Count(*) From Mediciones as M Inner Join SENSORES AS S ON M.IDSENSOR = S.IDSENSOR
			Where S.IDPAIS = PA.IDPAIS And M.LLUVIA = 0
		) AS CantNoLluvia
	From Paises AS PA
) AS Aux
Where Aux.CantNoLluvia > Aux.CantLluvia And Aux.CantLluvia > 0