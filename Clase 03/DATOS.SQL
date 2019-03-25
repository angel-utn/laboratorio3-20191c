Use Fabrica

Set Dateformat 'DMY'

Set Identity_Insert Clientes ON

-- Clientes
Insert into Clientes (ID, APELLIDOS, NOMBRES, FNAC, MAIL, TELEFONO, CELULAR, REGISTROWEB)
VALUES
(1, 'Mansilla',' Rodrigo','01/01/1990', 'rodrigo@mansilla.com','1111', '151111', 1),
(2, 'Robledo','Sergio', '02/02/1995','sergio@robledo.com','2222', null,	1),
(3,	'Kusters','Kevin','03/03/1998',null, null, null, 0),
(4,	'Ocampo', 'Eliana', '04/04/2000',null,'3333', '153333',	1),
(5, 'Rodriguez', 'Pablo', '09/09/1999', 'pablo@rodriguez.com.ar', '5555', '155555', 1),
(6, 'Gutierrez', 'Maria', '04/04/2000', 'maria@gutierrez.com.ar', '6666', null, 0),
(7, 'Hernandez', 'Josefina', '01/01/1990', null, null, '157777', 1),
(8, 'Lezcano', 'Mario', '04/04/1994', null, null, null, 0),
(9,	'Dloster', 'Kaniel', '08/08/1980', 'daniel@daniel.com',	'9999', '159999', 0),
(10, 'Falabuig', 'Cernando', '09/09/1990', null, null, '151010', 1)

Set Identity_Insert Clientes OFF

Set Identity_Insert Productos ON
-- Productos
Insert Into Productos (ID, DESCRIPCION, DIASCONSTRUCCION, PRECIO, PVM, CANTIDADMAYORISTA)
VALUES
(1,	'Ropero melamina pequeño', 5, 4500,	null, null),
(2,	'Sillas de roble', 2, 2000, 1733, 6),
(3,	'Mesa ratona redonda', 2, 2500,	null, null),
(4,	'Placard de pinotea', 9, 9900, 8000, 5),
(5, 'Juego de mesa de jardin', 14, 14500, null, null),
(6, 'Silla de cedro', 3, 1800, 1700, 6),
(7, 'Silla de bebé para comer', 4, 600, null, null),
(8, 'Ropero de melamina blanco grande', 10, 8650, null, null),
(9, 'Placard de tres puertas y dos cajones', 8, 2100, 1800, 5),
(10, 'Escritorio PC minimalista', 3, 4400, 4000, 10),
(11, 'Escritorio PC esquinero', 6, 8800, null, null),
(12, 'Mesa de campo', 3, 3500, 3300, 3)

Set Identity_Insert Productos OFF

-- Colaboradores
Insert into COLABORADORES(LEGAJO, APELLIDO, NOMBRES, GENERO, SUELDO, FECHA_INGRESO)
VALUES
(1000,'Di Como', 'Luis', 'M', 15500, '01/01/2015'),
(2000,'Medela',	'Matias', 'M', 14900, '03/01/2016'),
(3000,'Tidele',	'Alejandro', 'M', 16000, '06/06/2014'),
(4000,'De Lage', 'Marisa', 'F', 15800, '01/01/2015'),
(5000,'Semenza', 'Julio', 'M', 19000, '04/04/2010'),
(6000,'Zura', 'Ivan', 'M', 21200, '03/03/2007'),
(7000,'Espinola', 'Miguel', 'M', 24500, '02/02/2005'),
(8000, 'Simon', 'Angel', 'M', 1000000, '02/10/1986')

-- Pedidos
Insert Into Pedidos(IDCLIENTE, IDPRODUCTO, CANTIDAD, FECHASOLICITUD, FECHAFINALIZACION, COSTO, PAGO)
VALUES
(1, 1, 1, '10/02/2019', null, 4500, 1),
(2, 2, 6, '15/02/2019', '20/02/2019', 10400, 1),
(3, 3, 1, '04/03/2019', null, 2500, 0),
(4, 4, 1, '04/03/2019', '14/03/2019', 9900, 1),
(1, 12, 1, '04/03/2019', null, 3500, 1),
(9, 10, 2, '05/03/2019', '07/03/2019', 8800, 1),
(1, 9, 5, '06/03/2019', null, 9000, 0)

-- Colaboradores x pedido
Insert into COLABORADORES_X_PEDIDO(IDPEDIDO, LEGAJO) 
VALUES
(1, 1000),
(1, 2000),
(1, 3000),
(2, 1000),
(2, 4000),
(3, 5000),
(3, 6000),
(4, 1000),
(4, 7000),
(5, 6000),
(5, 7000),
(6, 1000),
(6, 2000),
(6, 3000),
(6, 4000),
(6, 5000),
(7, 1000)

-- Localidades
INSERT INTO LOCALIDADES(ID, NOMBRE)
VALUES
(1617, 'General Pacheco'),
(1648, 'Tigre'),
(1646, 'San Fernando'),
(1645, 'Virreyes'),
(1619, 'Garin'),
(1625, 'Escobar'),
(1629, 'Pilar'),
(1623, 'Ingeniero Maschwitz'),
(1621, 'Benavidez')

-- Envíos
INSERT INTO ENVIOS(ID, FECHA_ENVIO, FECHA_ENTREGA, DOMICILIO, CP, COSTO)
VALUES
(1, '17/02/2019', '18/02/2019', 'Estrada 4383', 1617, 650),
(4, '10/03/2019', null, 'Libertador 1010', 1646, 1400),
(6, '11/03/2019', '12/03/2019', 'Presidente Simon 9898', 1646, 2000)
