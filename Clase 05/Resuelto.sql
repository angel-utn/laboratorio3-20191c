--1) La cantidad de productos registrados.
Select count(*) as Cantidad from Productos

--2) La cantidad de productos registrados que requieran se�a.
Select count(*) as RequierenSe�a from Productos where Seña = 1 

--3) La cantidad de productos que registren un Precio Mayorista
Select count(*) as CantidadPrecioMayorista from Productos where PVM IS NOT NULL

Select count(PVM) AS CantidadPrecioMayorista from Productos

--4) El total recaudado en concepto de pedidos (indistantemente del pago).
select sum(costo) as Total from Pedidos

--5) El promedio de costos de env�o. 
Select avg(costo) as Promedio from Envios

--6) El promedio de recaudaci�n de pedidos que hayan sido pagados.
Select avg(costo) as Promedio from Pedidos where Pago = 1

--7) El precio m�s elevado de los productos.
Select Max(Precio) as MasCaro from Productos

--8) El menor costo de los env�os.
Select Min(Costo) as MasBarato from Envios

--9) Por cada cliente, el apellido y nombre del cliente y la cantidad de pedidos realizados.
Select C.Apellidos, C.Nombres, Count(*) AS Pedidos From Clientes as C
Inner Join Pedidos as P ON P.IDCLIENTE = C.ID
Group by C.APELLIDOS, C.NOMBRES

--10) Por cada cliente, el total gastado en concepto de pedidos (indistantemente del pago).
Select C.Apellidos, C.Nombres, Sum(Costo) AS TotalPedidos From Clientes as C
Inner Join Pedidos as P ON P.IDCLIENTE = C.ID
Group by C.APELLIDOS, C.NOMBRES

--11) Por cada categor�a de producto la cantidad de productos que pertenecen a cada categor�a. Listar Nombre de la categor�a y cantidad.
Select C.NOMBRE, Count(*) as CantProductos From CATEGORIAS as C
Inner join Productos aS P ON C.ID = P.IDCATEGORIA
Group by C.nombre

--12) Por cada material de producto la cantidad de productos que pertenecen a cada material. Listar Nombre del material y cantidad. Incluir en el listado aquellos materiales que no tienen productos asociados.
Select M.NOMBRE, Count(P.IDMATERIAL) as CantProductos From Materiales as M
Left join Productos aS P ON M.ID = P.IDMaterial
Group by M.nombre

--13) Por cada producto, la cantidad total recaudada en concepto de pedidos. Listar la descripci�n del producto y el total recaudado.
Select P.Descripcion, Sum(Costo) as Total From Productos as P
Inner Join Pedidos as PE ON P.ID = PE.IDPRODUCTO
Group By P.DESCRIPCION


--14) Por cada categor�a de producto el precio m�ximo del producto asociado a esa categor�a. Listar el nombre de la categor�a y el precio m�ximo encontrado.
Select C.Nombre, Max(Precio) As PrecioMaximo From Productos as P
Inner Join Categorias as C ON C.ID = P.IDCATEGORIA
Group By C.NOMBRE

--15) Por cada pedido, listar el c�digo de pedido y la cantidad de colaboradores que trabajaron en �l.
Select PE.ID, Count(*) as CantidadColaboradores FROM Pedidos as PE
Inner Join Colaboradores_x_Pedido AS CXP ON CXP.IDPEDIDO = PE.ID
Group by PE.ID

--16) Por cada colaborador, listar la cantidad de veces que realiz� colaboraciones en pedidos.
Select C.Apellido, C.Nombres, Count(*) as CantidadColaboraciones From COLABORADORES as C
INNER JOIN COLABORADORES_X_PEDIDO as CXP ON CXP.LEGAJO = C.LEGAJO
Group by C.Apellido, C.Nombres

--17) Por cada colaborador, listar la cantidad de veces que realiz� colaboraciones en pedidos distintos.
Select C.Apellido, C.Nombres, Count(Distinct CXP.IDPEDIDO) as CantidadColaboraciones From COLABORADORES as C
INNER JOIN COLABORADORES_X_PEDIDO as CXP ON CXP.LEGAJO = C.LEGAJO
Group by C.Apellido, C.Nombres

--18) Listar los nombres de las tareas que se hayan llevado a cabo m�s de dos veces entre todos los pedidos.
Select T.Nombre, count(*) AS Cantidad From Tareas as T
Inner Join COLABORADORES_X_PEDIDO as CXP ON CXP.IDTAREA = T.ID
Group by T.NOMBRE
Having Count(*) > 2

--19) Listar los clientes que no hayan realizado pedidos. Es decir, que hayan contabilizado cero pedidos.
Select C.Apellidos, C.Nombres, Count(P.ID) As Cantidad From Clientes as C
Left Join Pedidos as P ON C.ID = P.IDCLIENTE
Group by C.APELLIDOS, C.NOMBRES
Having Count(P.ID) = 0

--20) Listar los clientes que tengan al menos un pedido sin pagar. Listar apellido y nombres.
Select C.Apellidos, C.Nombres, Count(P.ID) As Cantidad From Clientes as C
Inner Join Pedidos as P ON C.ID = P.IDCLIENTE
Where P.Pago = 0
Group by C.APELLIDOS, C.NOMBRES
Having Count(P.ID) >= 1

-- 21) Los nombre de categor�as de productos cuyo precio promedio de los productos asociados a la categor�a superen el valor de $5000.
Select C.Nombre, AVG(P.Precio) as PPromedio From PRODUCTOS AS P
Inner Join Categorias as C ON C.ID = P.IDCATEGORIA
Group by C.NOMBRE
Having AVG(P.Precio) > 5000

-- 22) Por cada pedido, la cantidad de colaboraciones distintas que recibi�. Listar el IDPedido y la cantidad de colaboraciones.
Select PE.ID, Count(Distinct CxP.LEGAJO) AS Cantidad From Pedidos as PE
Inner Join COLABORADORES_X_PEDIDO as CXP ON CXP.IDPEDIDO = PE.ID
Group by PE.ID

-- 23) Por cada cliente, la cantidad de productos de cada material que compr�. Listar el apellido y nombre del cliente, el nombre del material y la cantidad de productos de ese material que compr�.
Select C.Apellidos, C.Nombres, M.Nombre, Count(*) as Cantidad From Clientes as C
Inner Join Pedidos as PE ON PE.IDCLIENTE = C.ID
Inner Join PRODUCTOS AS PR ON PR.ID = PE.IDPRODUCTO
Inner Join MATERIALES as M ON M.ID = PR.IDMATERIAL
Group by C.APELLIDOS, C.NOMBRES, M.NOMBRE

-- 24) Apellido y nombres de los clientes que hayan pedido m�s de un producto del mismo material.
Select C.Apellidos, C.Nombres as Cantidad From Clientes as C
Inner Join Pedidos as PE ON PE.IDCLIENTE = C.ID
Inner Join PRODUCTOS AS PR ON PR.ID = PE.IDPRODUCTO
Inner Join MATERIALES as M ON M.ID = PR.IDMATERIAL
Group by C.APELLIDOS, C.NOMBRES, M.NOMBRE
Having Count(*) > 1

-- 25) Apellido y nombres del cliente que haya pedido m�s productos de un mismo material
Select Top 1 C.Apellidos, C.Nombres, M.Nombre, Count(*) as Cantidad From Clientes as C
Inner Join Pedidos as PE ON PE.IDCLIENTE = C.ID
Inner Join PRODUCTOS AS PR ON PR.ID = PE.IDPRODUCTO
Inner Join MATERIALES as M ON M.ID = PR.IDMATERIAL
Group by C.APELLIDOS, C.NOMBRES, M.NOMBRE
Order by Cantidad Desc

-- 26) La cantidad de clientes distintos que compraron productos que no requieren seña.
Select Count(Distinct PE.IdCliente) As Cantidad From Pedidos as PE
Inner Join Clientes as C ON PE.IDCLIENTE = C.ID
Inner Join Productos as P ON P.ID = PE.IDPRODUCTO
Where P.SEÑA = 0