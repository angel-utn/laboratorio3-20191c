--K) Hacer un procedimiento almacenado que liste todos las mediciones registradas en el pa�s Argentina.
Create Procedure SP_MedicionesArgentinas
As
Begin
	Select M.* From Mediciones as M
	Inner Join Sensores as S ON S.IDSENSOR = M.IDSENSOR
	Inner Join Paises aS P ON P.IDPAIS = S.IDPAIS
	Where P.PAIS Like 'Argentina'
End

Exec SP_MedicionesArgentinas

--L) Hacer un procedimiento almacenado que reciba un @IDPais y liste todas las mediciones del pa�s recibido como par�metro.
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

--M) Hacer un procedimiento almacenado que reciba un @IDPais, un n�mero de @Mes y un n�mero de @A�o y liste la amplitud t�rmica de 
--dicho pa�s en ese per�odo.
Create Procedure SP_AmplitudTermica(
	@IDPais INT,
	@Mes SMALLINT,
	@A�o SMALLINT
)
AS
Begin
	Select MAX(M.Temperatura) - MIN(M.Temperatura) AS Amplitud From Mediciones as M
	Inner Join Sensores as S ON S.IDSENSOR = M.IDSENSOR
	Where S.IDPAIS = @IDPais AND MONTH(M.Fecha_Hora) = @Mes AND YEAR(M.FEcha_Hora) = @A�o
End

Exec SP_AmplitudTermica 1, 5, 2019

--N) Hacer un procedimiento almacenado que reciba un @IDPais y un @Nombre y registre un nuevo pa�s.
Create Procedure SP_AgregarPais(
	@IDPais INT,
	@Nombre Varchar(50)
)
AS
Begin
	Insert into Paises (IDPAIS, PAIS) Values (@IDPais, @Nombre)
End

Exec SP_AgregarPais 6, 'COLOMBIA'

--�) Modificar el anterior para que adem�s de generar un nuevo pa�s genere un nuevo sensor para ese pa�s. El nuevo n�mero de sensor 
--deber� ser el mayor valor del IDSensor registrado hasta el momento m�s uno.
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

--O) Hacer un procedimiento almacenado que reciba el @Nombre de un pa�s y si existe, elimine a dicho pa�s con todos sus sensores y mediciones.
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
		Print 'No existe el pa�s ' + @NombrePais
	END
End

exec SP_EliminarPais 'Argentina'