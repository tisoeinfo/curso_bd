-- En la semana 4 no podemos insertar registros sin antes crear nuestra BD y tener nuestras entidades creadas.
-- Creacion de BD
create database bd_control_atencion;

-- Posicionamiento de BD creada
use bd_control_atencion;

-- Creacion de la tabla Turnos
create table turnos (
id_turno int primary key,
nombre_turno varchar(50)
);

-- Creacion de la tabla Meseros que se relaciona con la tabla Turnos (id_turno)
create table meseros (
id_mesero int primary key,
nombre varchar(50),
ape_paterno varchar (50),
ape_materno varchar (50),
id_turno int,
foreign key (id_turno) references turnos(id_turno)
);

-- Tabla Clientes
create table clientes (
id_cliente int primary key,
nombre varchar(50)
);

-- Tabla Reservas
create table reservas (
id_reserva int primary key,
fecha datetime,
id_cliente int,
id_mesero int,
foreign key (id_cliente) references clientes(id_cliente),
foreign key (id_mesero) references meseros(id_mesero)
);


-- ====================================
-- INSERTS DE DATOS
-- ====================================

select * from turnos;

-- Turnos (solo 3)
INSERT INTO turnos (id_turno, nombre_turno) VALUES
(1, 'Mañana'),
(2, 'Tarde'),
(3, 'Noche');

-- INSERT INTO turnos (id_turno, nombre_turno) VALUES (1, 'Mañana');
-- INSERT INTO turnos (id_turno, nombre_turno) VALUES (1, 'Mañana');
-- INSERT INTO turnos (id_turno, nombre_turno) VALUES (1, 'Mañana');

-- Meseros (6 ejemplos)
INSERT INTO meseros (id_mesero, nombre, ape_paterno, ape_materno, id_turno) VALUES
(1, 'Carlos', 'López', 'García', 1),
(2, 'María', 'Rodríguez', 'Pérez', 1),
(3, 'José', 'Martínez', 'Sánchez', 2),
(4, 'Ana', 'Hernández', 'Díaz', 2),
(5, 'Luis', 'González', 'Ruiz', 3),
(6, 'Laura', 'Fernández', 'Moreno', 3);

-- Clientes (10 registros como pediste)
INSERT INTO clientes (id_cliente, nombre) VALUES
(1, 'Juan Pérez Morales'),
(2, 'Sofía Ramírez Torres'),
(3, 'Miguel Ángel Castro'),
(4, 'Valeria Mendoza Ortiz'),
(5, 'Roberto Salazar Vega'),
(6, 'Camila Fuentes Rivera'),
(7, 'Andrés Castillo Herrera'),
(8, 'Gabriela Navarro Luna'),
(9, 'Diego Armando Rivas'),
(10, 'Lucía Domínguez Flores');

-- Reservas (8 ejemplos)
INSERT INTO reservas (id_reserva, fecha, id_cliente, id_mesero) VALUES
(1, '2025-11-28 13:30:00', 1, 1),
(2, '2025-11-28 14:00:00', 3, 2),
(3, '2025-11-28 20:15:00', 5, 5),
(4, '2025-11-29 13:00:00', 2, 1),
(5, '2025-11-29 21:00:00', 7, 6),
(6, '2025-11-30 12:45:00', 4, 3),
(7, '2025-11-30 19:30:00', 8, 4),
(8, '2025-12-01 20:00:00', 10, 5);

-- Seleccionada todos los campos de la tabla
SELECT * from clientes;

-- Selecciona un campo en especifico
SELECT nombre from clientes;
SELECT id_mesero, nombre, ape_materno, ape_paterno from meseros;

-- Buscadores Exacto
SELECT * from clientes where nombre = 'Juan Pérez Morales';

-- Buscadores por caracteres
SELECT * from clientes where nombre like '%as%'

-- Ordenar de mayor a menor
SELECT * from clientes order by id_cliente desc

-- Aplicar Mayor y menor, esto trabaja con campos que sean en numeros (decimal) trabajas con : >< - where