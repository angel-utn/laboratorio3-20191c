--A) - Para cada pa�s listar el nombre del pa�s y la cantidad de mediciones donde se registraron lluvias y 
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

--B) - Para cada pa�s listar el nombre del pa�s y la temperatura m�xima hist�rica registrada.
Select PA.Pais, MAX(M.Temperatura) as Maximo From Paises as PA
Inner Join Sensores as S ON S.IDPAIS = PA.IDPAIS
Inner Join Mediciones aS M ON M.IDSENSOR = S.IDSENSOR
Group by PA.Pais

--C) - Para cada pa�s, listar el nombre y la cantidad de d�as transcurridos desde la �ltima vez que llovi�.
Select PA.Pais, 
	Datediff(day,
		(
			Select MAX(fecha_hora) from Mediciones as M Inner Join Sensores as S 
			on S.IDSENSOR = M.IDSENSOR WHERE M.LLUVIA > 0 AND S.IDPAIS = PA.IDPAIS
		), getdate()
		) As Diastranscurridos
From Paises AS PA

--D) - Por cada a�o, listar el promedio de temperatura.
Select Year(fecha_hora) AS A�o, AVG(temperatura) as Promedio from MEDICIONES
group by Year(fecha_hora)

--E) - Listar los nombres de todos los pa�ses que hayan registrado m�s mediciones sin lluvia que mediciones donde 
-- llovi� pero que al menos haya registrado alguna medici�n donde llovi�.
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