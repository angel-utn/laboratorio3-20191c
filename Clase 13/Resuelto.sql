/*
A) Hacer un trigger que no permita registrar contratos si una persona supera las 45 horas semanales en un mismo año (teniendo en cuenta todos los contratos de la persona en el año). Si ocurre informar "Persona no disponible" y cancelar la carga.
Además, todos los contratos serán aprobados automáticamente (Aprobado = 1) si la empresa está dentro de su presupuesto anual (sumatoria de importes de los contratos de la empresa en el año). Caso contrario, se registrará el contrato pero su estado de aprobación será 0.
*/
Create Trigger TR_PuntoA ON Contratos
After Insert
As
Begin
	Declare @HsTotales int
	Declare @DNI int
	Declare @IDEmpresa int
	Declare @Anio smallint
	Declare @Presupuesto money
	Declare @Gasto money
	Declare @Aprobado bit
	
	Select @DNI=Dni, @IDEmpresa=IdEmpresa, @Anio = anio
	from Inserted
	
	Select @HsTotales = SUM(HS_Semanales) from
	Contratos Where dni = @dni and anio = @anio
	
	if (@HSTotales > 45) begin
		rollback transaction
		raiserror('Persona no disponible', 16, 1)
	end	
	
	select @Presupuesto = presupuesto_anual from
	Empresas where ID = @IDEmpresa
	
	Select @Gasto = SUM(Importe_Anual) from
	Contratos where idempresa = @IDEmpresa and
	anio = @Anio
	
	if (@Gasto <= @Presupuesto) begin
		set @aprobado = 1
	end
	else begin
		set @aprobado = 0
	end
	
	update contratos set aprobado = @aprobado
	where id = (select id from inserted)	
End


--B) Hacer un procedimiento almacenado que reciba un a�o como par�metro y liste para cada empresa la
--sumatoria de importes de dicho a�o de los contratos que se encuentren aprobados. Adem�s, incluir la
--descripci�n de la empresa, el presupuesto anual y qu� porcentaje del presupuesto anual se ha utilizado
--(30 puntos)
Create Procedure SP_PuntoB(
	@anio smallint
)
as begin
	Select E.Descripcion, E.Presupuesto_Anual,
	(
	  Select Isnull(SUM(Importe_Anual), 0) from CONTRATOS
	  where IDEMPRESA = E.ID And Anio = @anio
	  and APROBADO = 1
	) as Sumatoria,
	(
	  Select Isnull(SUM(Importe_Anual), 0) from CONTRATOS
	  where IDEMPRESA = E.ID And Anio = @anio
	  and APROBADO = 1
	) / E.PRESUPUESTO_ANUAL * 100 AS Porcentaje
	From EMPRESAS as E
end

Exec SP_PuntoB 2019

--C) Hacer un procedimiento almacenado que reciba un DNI
-- y un a�o como par�metros en indique
--cu�ntas horas semanales tiene disponible esa persona 
-- en ese a�o. Recordar que el l�mite semanal por
--persona es de 45 horas. Es indistinto el estado de
-- aprobaci�n del contrato para este c�lculo. (20 puntos)
Create PRocedure SP_PuntoC(
	@dni bigint,
	@anio smallint
)
as
begin
	Select 45-isnull(SUM(HS_Semanales), 0) as CantHsDisp from CONTRATOS
	where DNI = @dni and ANIO = @anio	
end

exec sp_puntoC 2, 2019

/*
D) Hacer un trigger que no permite a una empresa registrar un contrato cuyo importe anual supere el 50% de su presupuesto anual. Indicar con un mensaje de error en caso de que esto ocurra. De lo contrario, registrar el contrato. (20 puntos)
*/
Create Trigger TR_PuntoD ON Contratos
INSTEAD OF INSERT
AS
BEGIN
	Declare @importe money
	Declare @idempresa bigint
	Declare @anio int
	Declare @presupuesto money

	select @importe = importe_anual, @idempresa = idempresa from inserted
	select @presupuesto = presupuesto_anual from empresas where idempresa = @idempresa

	if (@importe <= @presupuesto/2 ) BEGIN
		insert into contratos(idempresa, dni, anio, HS_Semanales, importe_anual, aprobado)
		select idempresa, dni, anio, hs_semanales, importe_anual, aprobado from inserted
	end
	else BEGIN
		raiserror('No se puede cargar el contrato', 16, 1)
	end
END