--  PRIMER EJEMPLO DE SUB CONSULTAS
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

-- USO DE IN EN SQL
SELECT * FROM empleados WHERE ID_EMPLEADO IN(1,2);

SELECT 
    id_empleado,
    id_gestor,
    id_departamento
FROM empleados
WHERE (id_gestor, id_departamento) IN (
        SELECT id_gestor, id_departamento
        FROM empleados
        WHERE nombre = 'John'
      )
AND nombre <> 'John';

-- ==================================================
-- SEGUNDO EJEMPLO APLICANDO LA ENTIDAD DUAL CON CASE 
-- EJERCICIO 1 (RECORDANDO)
SELECT
(CASE WHEN DUMMY ='X' THEN 'EXISTE EL VALOR X' END) AS DUMMY
FROM DUAL;

-- EJERCICIO 2
SELECT
(CASE WHEN DUMMY ='X' THEN 'EL VALOR ES X' END) AS DUMMY
FROM DUAL;

-- EJERCICIO 2
SELECT   
    MI_NOTA,
    (CASE WHEN MI_NOTA >='13' THEN 'APROBADO' ELSE 'DESAPROBADO' END) AS PROMEDIO 
    FROM
        (SELECT
            '15' AS MI_NOTA
        FROM DUAL) PRIMER_DUAL;

-- Eliminar para practicar el segundo ejemplo:
drop table empleados
-- Departamenos
CREATE TABLE departamentos (
    id_departamento NUMBER PRIMARY KEY,
    nombre_departamento VARCHAR2(40),
    id_ubicacion NUMBER
);

CREATE TABLE empleados (
    id_empleado NUMBER PRIMARY KEY,
    apellido VARCHAR2(40),
    id_departamento NUMBER,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);

INSERT INTO departamentos VALUES (10, 'Administración', 1700);
INSERT INTO departamentos VALUES (20, 'Ventas', 1800);   -- Este es el que coincidirá
INSERT INTO departamentos VALUES (30, 'Logística', 1900);

INSERT INTO empleados VALUES (1, 'Lopez', 10);
INSERT INTO empleados VALUES (2, 'Martinez', 20);
INSERT INTO empleados VALUES (3, 'Ramos', 20);
INSERT INTO empleados VALUES (4, 'García', 30);

SELECT 
    id_empleado,
    apellido,
    (CASE WHEN id_departamento = (
                SELECT id_departamento
                FROM departamentos
                WHERE id_ubicacion = 1800
             )
        THEN 'Canada'
        ELSE 'USA'
     END) AS ubicacion
FROM empleados;
