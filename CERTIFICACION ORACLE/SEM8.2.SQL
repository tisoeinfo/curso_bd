-- Ejemplo 1: SQL Dinámico básico (INSERT)
DECLARE
    v_sql VARCHAR2(500);
BEGIN
    v_sql := 'INSERT INTO empleados_demo (id_empleado, nombre, salario)
              VALUES (5, ''Pablo'', 2500)';

    EXECUTE IMMEDIATE v_sql;

    DBMS_OUTPUT.PUT_LINE('Registro insertado');
END;


------------------------------------------------------------------

-- Ejemplo 2: SQL Dinámico con parámetros (bind variables)
CREATE OR REPLACE PROCEDURE borrar_por_id (
    p_id_empleado NUMBER
)
IS
    v_sql VARCHAR2(500);
BEGIN
    v_sql := 'DELETE FROM empleados_demo WHERE id_empleado = :id';

    EXECUTE IMMEDIATE v_sql USING p_id_empleado;

    DBMS_OUTPUT.PUT_LINE('Registro borrado');
END;


-- 1. Parámetro del procedimiento: p_id_empleado NUMBER
-- * El valor viene desde fuera
-- * Podría venir de un usuario o aplicación
-- “Aquí es donde empieza el riesgo si no lo hacemos bien.”

-- 2. SQL con bind variable:   v_sql := 'DELETE FROM empleados_demo WHERE id_empleado = :id';
-- * :id NO es una variable PL/SQL
-- * Es un marcador de posición
-- * Oracle sabe que ahí irá un valor, no código

-- 3. EXECUTE IMMEDIATE v_sql USING p_id_empleado;
-- * Oracle reemplaza :id por el valor
-- * No concatena texto
-- * No interpreta código malicioso
-- “Aquí Oracle separa el SQL del dato.”

-- #Beneficios de usar bind variables
-- Más seguridad
-- Evita SQL Injection
-- Mejor rendimiento
-- Código profesional

------------------------------------------------------------------

-- Ejemplo 3: SQL Dinámico vulnerable (el más importante)
CREATE OR REPLACE PROCEDURE borrar_por_id_vulnerable (
    p_id_empleado VARCHAR2
)
IS
    v_sql VARCHAR2(500);
BEGIN
    v_sql := 'DELETE FROM empleados_demo WHERE id_empleado = ' || p_id_empleado;
    EXECUTE IMMEDIATE v_sql;
END;

--  ¿Dónde está el error?
'DELETE FROM empleados_demo WHERE id_empleado = ' || p_id_empleado
-- Se está pegando texto
-- Oracle no sabe qué es dato y qué es código
-- Todo se vuelve SQL

-- Ejecución peligrosa
BEGIN
    borrar_por_id_vulnerable('1 OR 1=1');
END;


-- Oracle ejecuta esto:
DELETE FROM empleados_demo WHERE id_empleado = 1 OR 1=1;
-- Resultado: se borra toda la tabla

-- ¿Por qué pasa esto?
-- * Concatenación directa
-- * Oracle ejecuta todo como SQL
-- * No hay validación
-- * Se produce SQL Injection

-- SQL dinámico mal usado no es un error… es una amenaza.
-- “Si hoy entienden este ejemplo, ya entienden por qué existen los ataques a bases de datos.”