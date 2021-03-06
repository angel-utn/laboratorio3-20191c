-- 1) Listado de todos los campos de todos los productos
SELECT * FROM PRODUCTOS

-- 2) Listado de Apellido, nombres y mail de todos los clientes (XLS)
SELECT APELLIDOS, NOMBRES, MAIL FROM CLIENTES

-- 3) Listado de los colaboradores ordenados por sueldo del mayor al menor.
SELECT * FROM COLABORADORES ORDER BY 6 DESC

SET DATEFORMAT 'DMY'
INSERT INTO COLABORADORES(LEGAJO, APELLIDO, NOMBRES, GENERO, SUELDO, FECHA_INGRESO)
VALUES (9000, 'DATALE', 'NAMIAN', 'M', 1000000, '10/02/1985')

-- 4) Listado de el/la colaborador/a con mejor sueldo. (XLS)
SELECT TOP 1 WITH TIES * FROM COLABORADORES ORDER BY SUELDO DESC

-- 5) Listado de todos los campos del colaborador con legajo 1000
SELECT * FROM COLABORADORES WHERE LEGAJO = 1000

-- 6) Listado de todos los productos cuyo precio de venta sea mayor a 5000
SELECT * FROM PRODUCTOS WHERE PRECIO > 5000

-- 7) Listado de los apellidos y nombres de los clientes y su aÑo de nacimiento.
SELECT APELLIDOS + ', '+ NOMBRES AS APENOM, YEAR(FNAC) AS [AÑO NACIMIENTO] FROM CLIENTES

-- 7) Listado todos los pedidos incluyendo la demora (en d�as) de la finalizaci�n del producto. (XLS)
SELECT *, ISNULL(DATEDIFF(DAY, FECHASOLICITUD, FECHAFINALIZACION), -1) AS DEMORA FROM PEDIDOS

SELECT ID, ISNULL(MAIL, 'SIN MAIL') AS MAIL FROM CLIENTES

-- 8) Listado de los apellidos y nombres de los clientes que se hayan registrado a trav�s de la web y que hayan nacido
-- despu�s del a�o 1990.
SELECT APELLIDOS, NOMBRES FROM CLIENTES WHERE REGISTROWEB = 1 AND YEAR(FNAC) > 1990

-- 9) Listado de los productos cuya construcci�n pueda hacerse en 2 d�as o su precio sea mayor a 8000. (XLS)
SELECT * FROM PRODUCTOS WHERE DIASCONSTRUCCION = 2 OR PRECIO > 8000

-- 10) Listado de todos los productos cuyo precio de venta se encuentre 
-- entre 3000 y 7000. (XLS)
SELECT * FROM PRODUCTOS WHERE PRECIO BETWEEN 3000 AND 7000

-- 11) Listado de todos los clientes cuya fecha de nacimiento sea 
-- entre '1/1/1990' y '2/2/1991'

-- 12) Todos los pedidos de los clientes con IDCLIENTE 1, 2 y 9
SELECT * FROM PEDIDOS WHERE IDCLIENTE IN (1, 2, 9)

-- 13) Todos los pedidos de los clientes que no tengan el IDCLIENTE (3, 5 y 9) (XLS)
SELECT * FROM PEDIDOS WHERE IDCLIENTE NOT IN (3, 5, 9)

-- 14) Todos los clientes que tengan mail
SELECT * FROM CLIENTES WHERE MAIL IS NOT NULL

-- 15) Todos los clientes que tengan mail pero no celular (XLS)
SELECT * FROM CLIENTES WHERE MAIL IS NOT NULL AND CELULAR IS NULL

-- 16) Todos los clientes cuyo apellido finalice con el texto 'EZ'
SELECT * FROM CLIENTES WHERE APELLIDOS LIKE '%EZ'

-- 17) Todos los clientes cuyo apellido contenga el texto 'EZ'
SELECT * FROM CLIENTES WHERE APELLIDOS LIKE '%EZ%'

-- 18) Todos los colaboradores cuyo nombre comience con 'A'
SELECT * FROM COLABORADORES WHERE NOMBRES LIKE 'A%'

-- 19) Todos los colaboradores cuyo nombre comience con vocal
SELECT * FROM COLABORADORES WHERE NOMBRES LIKE '[AEIOU]%'

-- 20) Todos los colaboradores cuyo nombre no comience con vocal
SELECT * FROM COLABORADORES WHERE NOMBRES LIKE '[A-M]%'

-- 21) Todos lo colaboradores cuyo apellido contenga un 
-- espacio en su tercer caracter
SELECT * FROM COLABORADORES WHERE APELLIDO LIKE '___C%'

-- 22) Apellido y nombres de los clientes y una columna 
-- con un dato de contacto en el siguiente 
-- orden de prioridad: Mail, Telefono, Celular. (XLS)
SELECT APELLIDOS, NOMBRES, COALESCE(MAIL, TELEFONO, CELULAR) AS CONTACTO FROM CLIENTES

