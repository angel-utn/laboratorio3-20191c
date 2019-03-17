Create Database Clase1
Go
Use Clase1
Go
Create Table Jefes(
	ID int not null primary key identity(1, 1),
	Apellidos varchar(50) not null,
	Nombres varchar(50) not null,
	Sueldo money not null check (Sueldo > 0) -- El sueldo debe ser superior a 0.
)
go
Create Table Areas(
	ID int not null primary key identity(1, 1),
	Nombre varchar(50) not null,
	IDJefe int null foreign key references Jefes(ID) -- Al aceptar null, un área podría no tener un jefe.
)
go
Create Table Empleados(
	DNI varchar(10) not null primary key,
	IDArea int not null foreign key references Areas(ID),
	Apellidos varchar(50) not null,
	Nombres varchar(50) not null,
	Genero char null check (Genero = 'M' or Genero ='F') -- Al aceptar null, un empleado podría no indicar su género. Si lo hace, debe optar por M o F.
)