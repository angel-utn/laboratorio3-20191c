--K) Hacer un procedimiento almacenado que liste todos las mediciones registradas en el país Argentina.
Create Procedure SP_MedicionesArgentinas
As
Begin
	Select M.* From Mediciones as M
	Inner Join Sensores as S ON S.IDSENSOR = M.IDSENSOR
	Inner Join Paises aS P ON P.IDPAIS = S.IDPAIS
	Where P.PAIS Like 'Argentina'
End

Exec SP_MedicionesArgentinas

--L) Hacer un procedimiento almacenado que reciba un @IDPais y liste todas las mediciones del país recibido como parámetro.
Create Procedure SP_MedicionesPais(
	@IDPais INT
)
As
Begin
	Select * From Mediciones as M
	Inner Join Sensores as S ON S.IDSENSOR = M.IDSENSOR
	Inner Join Paises aS P ON P.IDPAIS = S.IDPAIS
	Where P.IDPAIS = @IDPais
End

exec SP_MedicionesPais 1

--M) Hacer un procedimiento almacenado que reciba un @IDPais, un número de @Mes y un número de @Año y liste la amplitud térmica de 
--dicho país en ese período.
Create Procedure SP_AmplitudTermica(
	@IDPais INT,
	@Mes SMALLINT,
	@Año SMALLINT
)
AS
Begin
	Select MAX(M.Temperatura) - MIN(M.Temperatura) AS Amplitud From Mediciones as M
	Inner Join Sensores as S ON S.IDSENSOR = M.IDSENSOR
	Where S.IDPAIS = @IDPais AND MONTH(M.Fecha_Hora) = @Mes AND YEAR(M.FEcha_Hora) = @Año
End

Exec SP_AmplitudTermica 1, 5, 2019

--N) Hacer un procedimiento almacenado que reciba un @IDPais y un @Nombre y registre un nuevo país.
Create Procedure SP_AgregarPais(
	@IDPais INT,
	@Nombre Varchar(50)
)
AS
Begin
	Insert into Paises (IDPAIS, PAIS) Values (@IDPais, @Nombre)
End

Exec SP_AgregarPais 6, 'COLOMBIA'

--Ñ) Modificar el anterior para que además de generar un nuevo país genere un nuevo sensor para ese país. El nuevo número de sensor 
--deberá ser el mayor valor del IDSensor registrado hasta el momento más uno.
Alter Procedure SP_AgregarPais(
	@IDPais INT,
	@Nombre Varchar(50)
)
AS
Begin
	Declare @IDSensor INT
	Select @IDSensor = MAX(IDSENSOR) From Sensores
	Insert into Paises (IDPAIS, PAIS) Values (@IDPais, @Nombre)
	Insert into SENSORES(IDSensor, IDPais) Values (@IDSensor+1, @IdPais)
End

Exec SP_AgregarPais 7, 'Ecuador'

--O) Hacer un procedimiento almacenado que reciba el @Nombre de un país y si existe, elimine a dicho país con todos sus sensores y mediciones.
Create Procedure SP_EliminarPais(
	@NombrePais varchar(50)
)
As
Begin
	DECLARE @IDPais INT
	SELECT @IDPais = IDPAIS From Paises Where Pais = @NombrePais
	IF @IDPais IS NOT NULL BEGIN
		DELETE FROM Mediciones Where IDSensor IN (
			Select IDSensor From Sensores Where IdPais = @Idpais
		)

		Delete from Sensores where IdPais = @Idpais

		Delete from Paises where IDpais = @Idpais

	END
	ELSE Begin
		Print 'No existe el país ' + @NombrePais
	END
End

exec SP_EliminarPais 'Argentina'