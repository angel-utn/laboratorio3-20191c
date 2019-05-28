/*
-- Crespo, Francisco
4 - Cuando se registre una nueva cuenta. Realizar el alta 
automática de una tarjeta de débito a dicha
cuenta. Se deberá:
- Crear la nueva cuenta
- Crear la nueva tarjeta de débido (Tarjeta tipo ‘D’)
*/
create trigger tr_nuevo_cuenta on cuentas
after insert
as
begin
	declare @idcuenta bigint
	select @idcuenta = idcuenta from inserted
	insert into tarjetas(idcuenta,tipo,estado)
	values(@idcuenta,'d',1)
end

select * from cuentas

insert into cuentas (idcuenta,idcliente,tipo,limite,saldo,estado)
values(5,1,'CA',-3000000,5000,1)

select * from tarjetas

/*
-- Gonzalez, Juan
5 - Cuando se registre un nuevo cliente. Realizar el alta 
automática de una cuenta a dicho cliente. Se
deberá:
- Crear el nuevo registro de cliente.
- Crear una nueva cuenta (Tipo de cuenta 'CA', Saldo 0, Límite 0)
*/
Create Trigger TRG_ALTA_CLIENTE ON CLIENTES
After insert
AS
BEGIN
	Declare @Id bigint
	select @Id = IDCLIENTE from inserted
	
	Insert into CUENTAS
	values ((select MAX(IDCUENTA)+1 from cuentas),
			@Id,
			'CA',
			0,
			0,
			1)

END

/*
Cassano, Juan
Lescano, Leandro
-----------------
7 - Cuando se registre un nuevo movimiento. Actualizar el saldo 
de la cuenta interviniente. Se deberá:
- Agregar el nuevo movimientos
- Actualizar el saldo
*/

create trigger TR_NuevoMovimiento on MOVIMIENTOS
after insert
as
begin
declare @Movimiento money
declare @IDM int
declare @IDT char
Select @Movimiento = IMPORTE, @IDM = IDCUENTA, @IDT = TIPO from INSERTED
if @IDT = 'D'
begin
set @Movimiento = @Movimiento *-1
end
update CUENTAS set SALDO = SALDO + @Movimiento where IDCUENTA = @IDM
end

Insert into MOVIMIENTOS(IDCuenta, Importe, Tipo, Fecha, Estado)
Values (3,60,'D',GETDATE(),1)

Select * FROM CUENTAS
Select * FROM MOVIMIENTOS

/*
Zura, Ivan
Barzola, Santiago
-----------------
8 - Cuando se registre una nueva transferencia. 
Agregar los movimientos correspondientes si las
cuentas de origen y destino son distintas. Se deberá:
- Agregar la nueva transferencia
- Agregar el movimiento a la cuenta de origen
- Agregar el movimiento a la cuenta de destino
*/
ALTER TRIGGER TranferenciasMovimientos ON TRANSFERENCIAS
AFTER INSERT
AS
BEGIN
	DECLARE @IDTRANSFERENCIA	bigint
	DECLARE @ORIGEN	bigint
	DECLARE @DESTINO	bigint
	DECLARE @IMPORTE	money
	select @IDTRANSFERENCIA = IDTRANSFERENCIA, @ORIGEN = ORIGEN,
	@DESTINO = DESTINO, @IMPORTE = IMPORTE from INSERTED
	IF @ORIGEN != @DESTINO
	BEGIN
		insert into movimientos (IDCUENTA, IMPORTE, TIPO, FECHA, ESTADO)
		VALUES (@ORIGEN, @IMPORTE, 'D', GETDATE(), 1)
		insert into movimientos (IDCUENTA, IMPORTE, TIPO, FECHA, ESTADO)
		VALUES (@DESTINO, @IMPORTE, 'C', GETDATE(), 1)
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
	END
	
END
insert into transferencias (ORIGEN, DESTINO, IMPORTE, FECHA, ESTADO)
VALUES (1, 1, 150, GETDATE(), 1)

select * from cuentas
select * from transferencias
select * from movimientos

