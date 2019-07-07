/*
1) - Elaborar un trigger que al ingresar un viaje verifique que si el mismo 
supera los 800Km s�lo pueda ser realizado por un cami�n cuyo a�o de 
patentamiento no supere los cinco a�os de antig�edad. Indicarlo con un 
mensaje que informe "Cami�n demasiado antiguo para realizar el viaje". 
Caso contrario, registrar el viaje.
(25 puntos)
*/
Create Trigger tr_punto1 on Viajes
instead of insert
as
begin
	declare @km decimal(6,2)
	declare @patente varchar(10)
	declare @ño smallint
	declare @actual smallint
	
	select @patente = patente, @km = kms from inserted
	
	select @año = año from camiones where patente = @patente
	
	select @actual = year(getdate())
	
	if (@km > 800 and @actual - @año > 5) begin
		raiserror('Cami�n demasiado antiguo para realizar el viaje', 16, 1)
	end
	else begin
		insert into Viajes (Fecha, Patente, Kms, Estado)
		select Fecha, patente, kms, estado from inserted
	end
	
end


/*
2) - Elaborar un trigger que al ingresar un registro de encomienda verifique 
que dicha encomienda no supere el peso total que tolera el cami�n que realiza
el viaje. En caso de superarlo mostrar el mensaje "Encomienda sobrepasa el 
peso m�ximo" y cancelar la carga.
Otra verificaci�n que deber� hacer es que el viaje no haya sido realizado, 
en caso de haber sido realizado mostrar el mensaje "Viaje ya realizado" y 
cancelar la carga.
Calcular el costo de la encomienda a partir del peso de la misma. Ser� $15 
por cada kilogramo para viajes de hasta 500 kil�metros y $25 por cada 
kilogramo para viajes que superen los 500 kil�metros.
Si no hay errores, registrar la encomienda con el costo calculado.
(30 puntos)
*/
alter trigger tr_punto2 on Paquetes
after insert
as
begin
	declare @acumulado decimal(6, 2)
	declare @capacidad smallint
	declare @patente varchar(10)
	declare @idviaje bigint
	declare @idpaquete bigint
	declare @fecha date
	declare @costo money
	declare @kms decimal (6, 2)
	declare @peso decimal (6, 2)
	
	select @idpaquete = ID, @idviaje = idviaje, @peso = peso from inserted
	select @patente = patente, @kms = kms, @fecha = fecha from viajes where id = @idviaje
	select @acumulado = isnull(sum(peso), 0) from paquetes where idviaje = @idviaje
	select @capacidad=capacidad from camiones where patente = @patente
	
	
	if @acumulado > @capacidad begin
		rollback tran
		raiserror('Encomienda sobrepasa el peso m�ximo', 16, 1)
	end
	if @fecha < getdate() begin
		rollback tran
		raiserror('Viaje ya realizado', 16, 1)
	end
	if @kms <= 500 begin
		set @costo = @peso * 15
	end
	else begin
		set @costo = @peso * 25
	end
	update paquetes set costo = @costo where id = @idpaquete
	
end

/*
3) - Realizar un procedimiento almacenado que reciba como par�metro un 
IDViaje y lo cancele si la sumatoria de los pesos de los paquetes que lleva 
no supera la mitad de la capacidad del cami�n.
NOTA: La cancelaci�n de un viaje se realiza modificando el Estado del viaje 
a False. 
(25 puntos)
*/
alter procedure sp_punto3(
	@idviaje bigint
)
as
begin
	declare @sumatoria decimal(6, 2)
	declare @patente varchar(10)
	declare @capacidad smallint
	
	select @patente = patente from viajes where id = @idviaje
	select @sumatoria = isnull(sum(peso),0) from paquetes where idviaje = @idviaje
	select @capacidad=capacidad from camiones where patente = @patente
	
	if @sumatoria < @capacidad / 2 begin
		update viajes set estado = 0 where id = @idviaje
	end
end

/*
4) - Realizar un procedimiento almacenado que reciba como par�metro dos 
fechas, una de inicio y otra de fin y liste todos los viajes que se 
realizaron entre esas fechas. El listado deber� incluir para cada viaje: 
El c�digo de viaje, los kms realizados y el total recaudado en concepto de 
encomiendas. 
(20 puntos)
*/
create procedure sp_punto4(
	@fi date,
	@ff date
)
as
BEGIN
	Select v.Id, v.Kms, isnull(sum(p.costo), 0) as Suma from viajes as v inner join paquetes as p
	on v.id = p.idviaje
	where v.fecha between @fi and @ff
	group by v.id, v.kms
end