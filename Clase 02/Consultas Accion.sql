INSERT INTO PRODUCTOS(DESCRIPCION, PRECIO, PVM, CANTIDADMAYORISTA, DIASCONSTRUCCION)
VALUES ('ROPERO PINOTEA', 10000, NULL, NULL, 25)

INSERT INTO PRODUCTOS(DESCRIPCION, PRECIO, PVM, CANTIDADMAYORISTA, DIASCONSTRUCCION)
VALUES ('SILLA UNIVERSITARIA', 500, 499, 6, 10)

UPDATE PRODUCTOS SET DIASCONSTRUCCION = 200
WHERE ID = 1 OR ID = 3

DELETE FROM PRODUCTOS WHERE ID = 3