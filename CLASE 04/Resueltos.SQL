Use FABRICA

/*
1) Un listado con el código de producto, descripción del producto, precio de venta y nombre de la categoría del producto 
(sólo de los que poseen categoría de producto).
*/
Select P.ID, P.Descripcion, P.PRECIO, C.Nombre from Productos AS P
INNER JOIN Categorias AS C ON P.IDCATEGORIA = C.ID

/*
2) Un listado con el código de producto, descripción del producto, precio de venta y nombre de la categoría del producto 
(Todos los productos incluso los que no posean categoría de producto).
*/
Select P.ID, P.Descripcion, P.PRECIO, C.Nombre from Productos AS P
LEFT JOIN Categorias AS C ON P.IDCATEGORIA = C.ID

/*
3) Un listado con el código de producto, descripción del producto, precio de venta y nombre de la categoría del producto 
(Todas las categorías de producto incluso las que no posean productos asociados a ellas).
*/
Select P.ID, P.Descripcion, P.PRECIO, C.Nombre from Productos AS P
RIGHT JOIN Categorias AS C ON P.IDCATEGORIA = C.ID


/*
4) Un listado con el código de producto, descripción del producto, precio de venta y nombre de la categoría del producto 
(Todos los productos y todas las categorías aunque no haya registros relacionados entre sí).
*/
Select P.ID, P.Descripcion, P.PRECIO, C.Nombre from Productos AS P
FULL JOIN Categorias AS C ON P.IDCATEGORIA = C.ID


/*
5) Un listado con el código de producto, descripción del producto, precio de venta y nombre del material. 
De todos los productos que pertenezcan a la categoría con nombre "Placards".
*/
Select P.ID, P.Descripcion, P.PRECIO, C.Nombre, M.Nombre from Productos AS P
INNER JOIN Categorias AS C ON P.IDCATEGORIA = C.ID
INNER JOIN Materiales AS M ON P.IDMATERIAL = M.ID
Where C.Nombre LIKE 'Placards'

/*
6) Por cada pedido con fecha de solicitud en Marzo de 2019, listar código de pedido, nombre del producto, categoría del producto, 
apellido y nombres del cliente y el costo.
*/
Select PE.ID, PR.Descripcion, C.Nombre, CL.Apellidos, CL.Nombres, PE.Costo
FROM Pedidos AS PE
INNER JOIN Clientes AS CL ON PE.IDCLIENTE = CL.ID
INNER JOIN Productos AS PR ON PE.IDPRODUCTO = PR.ID
INNER JOIN Categorias AS C ON PR.IDCATEGORIA = C.ID
WHERE MONTH(PE.FECHASOLICITUD) = 3 AND YEAR(PE.FECHASOLICITUD) = 2019

/*
7) Listar apellidos y nombres de todos los clientes que no hayan abonado un producto solicitado hace más de 15 días.
*/
Select CL.Apellidos, CL.Nombres from Clientes as CL
INNER JOIN Pedidos AS PE ON PE.IDCliente = CL.ID
Where DateDiff(Day, PE.FechaSolicitud, getdate()) > 15 AND PE.PAGO = 0

/*
8) Listar apellido y nombres de los colaboradores que trabajaron en los pedidos 1, 2 y 3. Listarlos sin repeticiones.
*/
Select Distinct C.Apellido, C.Nombres from Colaboradores as C
INNER JOIN COLABORADORES_X_PEDIDO as CxP ON C.LEGAJO = CxP.LEGAJO
Where CxP.IDPEDIDO IN (1, 2, 3)

/*
9) Listado de pedidos que hayan sido enviados. Incluir en el listado el código de pedido, la fecha de envío, 
apellido y nombre del cliente y el domicilio de envío.
*/
Select PE.ID, E.FECHA_ENVIO, CL.Apellidos, CL.Nombres, E.Domicilio, L.Nombre from Pedidos aS PE
Inner Join Envios as E ON PE.ID = E.ID
Inner Join Clientes as CL ON PE.IDCLIENTE = CL.ID
Inner Join Localidades as L ON E.CP = L.ID

/*
10) Listado de pedidos que no hayan sido enviados. Incluir en el listado el código de pedido, el costo y todos los datos del cliente.
*/
Select PE.ID, PE.Costo, CL.* From Pedidos as PE
Inner Join Clientes as CL ON PE.IDCLIENTE = CL.ID
Left Join Envios as E ON E.ID = PE.ID
Where E.ID is null


/*
11) Listado con los código de pedido, legajo, apellido y nombres del colaborador que hayan realizado la tarea de 'Ensamblado' en 
un producto de categoría 'Placards'.
*/
Select PE.ID, C.Legajo, C.Apellido, C.Nombres From Pedidos as PE
Inner Join COLABORADORES_X_PEDIDO AS CxP ON PE.ID = CxP.IDPEDIDO
Inner Join COLABORADORES as C On C.Legajo = Cxp.LEGAJO
Inner Join Tareas As T ON T.ID = Cxp.IDTAREA
Inner Join Productos as PR ON PR.ID = PE.IDPRODUCTO
Inner Join Categorias AS CA ON Ca.ID = PR.IDCATEGORIA
Where T.Nombre Like 'Ensamblado' AND CA.Nombre Like 'Placards'


/*
12) Nombre de todos los materiales que no se hayan utilizado en ningún producto.
*/
Select M.* From Materiales as M
LEFT JOIN Productos as PR ON PR.IDMATERIAL = M.ID
WHERE PR.ID IS NULL


/*
13) Todos los datos de los clientes que hayan comprado al menos un producto en Febrero de 2019.
*/
Select C.* From Clientes as C
Inner Join Pedidos as PE ON PE.IDCLIENTE = C.ID
Where Month(PE.FechaSolicitud) = 2 AND Year(PE.FechaSolicitud) = 2019

/*
14) Nombre y apellido y nombre de todas las tareas realizadas por el colaborador con Legajo número 1000. 
El listado no debe admitir registrados duplicados.
*/
Select Distinct T.NOMBRE From Tareas as T
Inner Join COLABORADORES_X_PEDIDO as CxP ON CxP.IDTAREA = T.ID
Where CxP.LEGAJO = 1000


/*
15) Listado de pedidos con ID, Apellido y nombre del cliente, costo de pedido, fecha de envío, 
domicilio de envío, costo de envío y costo total. El costo total es el costo de pedido más el costo de envío.
 En el listado deben figurar todos los pedidos, incluso los que no fueron enviados. 
 El costo de envío para dichos productos será de $0.
*/
Select PE.ID, CL.Apellidos, CL.Nombres, PE.Costo, E.Fecha_Envio, E.Domicilio, IsNull(E.Costo, 0) As 'Costo envío', PE.Costo + IsNull(E.Costo, 0) AS Costo_Total
From Pedidos as PE
Left Join Envios as E ON E.ID = PE.ID
Inner Join Clientes as CL ON CL.ID = PE.ID