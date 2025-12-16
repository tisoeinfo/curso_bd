-- USO DE COMMIT, ROLLBACK Y SAVEPOINT

CREATE TABLE empleados (
    id_empleado      NUMBER PRIMARY KEY,
    nombre           VARCHAR2(30),
    apellido         VARCHAR2(30),
    id_gestor        NUMBER,
    id_departamento  NUMBER
);


INSERT INTO empleados VALUES (1, 'John', 'Perez', 100, 10);
INSERT INTO empleados VALUES (2, 'Ana',  'Lopez', 100, 10);
INSERT INTO empleados VALUES (3, 'Carlos', 'Diaz', 100, 10);
INSERT INTO empleados VALUES (4, 'Maria', 'Ramos', 200, 20);
INSERT INTO empleados VALUES (5, 'John', 'Gomez', 200, 20);
INSERT INTO empleados VALUES (6, 'Luis', 'Silva', 200, 20);
INSERT INTO empleados VALUES (7, 'Pedro', 'Mora', 300, 30);
INSERT INTO empleados VALUES (8, 'Lucia', 'Huaman', 300, 40);


-- ==================================================
-- ¿Qué es COMMIT?
-- COMMIT guarda definitivamente los cambios realizados en la base de datos.
-- Después de un COMMIT, ya no se puede deshacer lo que se hizo.
UPDATE empleados SET apellido = 'Pérez Modificado'  WHERE id_empleado = 1;
COMMIT;

-- ==================================================
-- ¿Qué es ROLLBACK?
-- ROLLBACK deshace los cambios realizados en la base de datos desde el último
UPDATE empleados SET apellido = 'Error' WHERE id_empleado = 2;
ROLLBACK;

-- ==================================================
-- ¿Qué es SAVEPOINT?
-- Un SAVEPOINT es un punto intermedio al que puedes volver sin perder todos los cambios.

-- Paso 1: Primer cambio + SAVEPOINT 1
UPDATE empleados SET apellido = 'Prueba1' WHERE id_empleado = 1;
SAVEPOINT sp1;
-- Cambio hecho al empleado 1
-- Se guarda el punto sp1

-- Paso 2: Segundo cambio + SAVEPOINT 2
UPDATE empleados SET apellido = 'Prueba2' WHERE id_empleado = 2;
SAVEPOINT sp2;
-- Cambio hecho al empleado 2
-- Se guarda el punto sp2

-- Paso 3: Tercer cambio + SAVEPOINT 3
UPDATE empleados SET apellido = 'Prueba3' WHERE id_empleado = 3;
SAVEPOINT sp3;
-- Cambio hecho al empleado 3
-- Se guarda el punto sp3

-- Paso 4: Cuarto cambio + SAVEPOINT 4
UPDATE empleados SET apellido = 'Prueba4' WHERE id_empleado = 4;
SAVEPOINT sp4;
-- Cambio hecho al empleado 4
-- Se guarda el punto sp4

-- Paso 5: Regresamos a SAVEPOINT 2 (NO al último)
ROLLBACK TO sp2;
