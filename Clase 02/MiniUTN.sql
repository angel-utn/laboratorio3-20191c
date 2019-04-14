CREATE DATABASE MINIUTN
GO
USE MINIUTN
GO
create table alumnos
(
	legajo int primary key not null,
	apellido varchar(30) not null,
	nombre varchar (30)not null,
	mail varchar(250) not null unique
)
GO
create table carreras
(
	id_carrera int primary key identity(1,1),
	nombre varchar(50) not null,
	duracion tinyint not null check(duracion >0)
)
GO
create table materias
( 
	id int primary key not null identity(1,1),
	nombre varchar(50) not null,
	idcarrera int foreign key references carreras (id_carrera) not null
)
GO
Drop Table Inscripciones

Create Table Inscripciones(
	ID bigint not null primary key identity(1, 1),
	Legajo int not null foreign key references Alumnos(Legajo),
	IDMateria int not null foreign key references Materias(ID),
	Año smallint not null,
	Cuatrimestre char null check(Cuatrimestre = '1' OR Cuatrimestre = '2'),
	Estado char not null check(Estado IN ('L', 'R', 'P', 'A')),
	Unique(Legajo, IDMateria, Año, Cuatrimestre)
)