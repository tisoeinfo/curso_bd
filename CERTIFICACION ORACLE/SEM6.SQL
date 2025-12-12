/* -----------------------------------------------------------
   SEMANA 6 – SEGURIDAD EN ORACLE (Resumen práctico)

   1. ¿Qué es un usuario?
      Es una cuenta que puede conectarse y crear/administrar 
      objetos en la base de datos, según los privilegios otorgados.

   2. ¿Qué es un privilegio?
      Es un permiso para realizar una acción. 
      Se divide en:
      - Privilegios del sistema: CREATE SESSION, CREATE TABLE, etc.
      - Privilegios sobre objetos: SELECT, INSERT, UPDATE, DELETE.

   3. ¿Qué es GRANT?
      Sentencia para otorgar privilegios o roles.
      GRANT permiso TO usuario;

   4. ¿Qué es REVOKE?
      Sentencia para quitar privilegios o roles.
      REVOKE permiso FROM usuario;

   5. ¿Qué es un rol?
      Es un conjunto de privilegios que se pueden otorgar a uno 
      o varios usuarios para facilitar la administración.

   6. ¿Qué es DROP USER ... CASCADE?
      Elimina un usuario y todos sus objetos.

   Objetivo de la clase:
      - Crear usuarios
      - Asignar privilegios individuales
      - Crear roles personalizados
      - Otorgar roles a usuarios
      - Revocar permisos
      - Eliminar usuarios y roles
------------------------------------------------------------- */
--------------------------------------------------------------
-- 1. CREACIÓN DE USUARIOS
--------------------------------------------------------------
CREATE USER C##SISE_CO IDENTIFIED BY "123";
CREATE USER C##SISE_SM IDENTIFIED BY "123";
CREATE USER C##SISE_PP IDENTIFIED BY "123";

--------------------------------------------------------------
-- 2. OTORGAR PRIVILEGIOS DE SISTEMA (NO COMO DBA)
--------------------------------------------------------------
GRANT CREATE SESSION TO C##SISE_CO;       -- Permite conectarse
GRANT CREATE TABLE TO C##SISE_CO;         -- Crear tablas
GRANT CREATE PROCEDURE TO C##SISE_CO;     -- Crear procedimientos
GRANT CREATE TRIGGER TO C##SISE_CO;       -- Crear triggers
GRANT CREATE VIEW TO C##SISE_CO;          -- Crear vistas
GRANT CREATE SYNONYM TO C##SISE_CO;       -- Crear sinónimos

--------------------------------------------------------------
-- 3. OTORGAR PRIVILEGIOS SOBRE OBJETOS (TABLAS)
-- Ejemplo: usuario SISE_CO quiere manipular tablas de SUCURSALES
--------------------------------------------------------------
GRANT ALL ON C##SUCURSALES.categorias TO C##SISE_CO;  
-- ALL = SELECT, INSERT, UPDATE, DELETE

--------------------------------------------------------------
-- 4. CREACIÓN DE ROLES PERSONALIZADOS
--------------------------------------------------------------
CREATE ROLE C##ACCESO_OBJETOS;

-- Privilegios sobre objetos
GRANT SELECT, INSERT, UPDATE, DELETE ON C##SUCURSALES.categorias TO C##ACCESO_OBJETOS;

GRANT SELECT, INSERT, UPDATE, DELETE ON C##SUCURSALES.productos TO C##ACCESO_OBJETOS;

-- NOTA: permisos para procedures, triggers → tarea

--------------------------------------------------------------
-- 5. CONSULTAR ROLES
--------------------------------------------------------------
SELECT * FROM DBA_ROLES WHERE ROLE = 'C##ACCESO_OBJETOS';

--------------------------------------------------------------
-- 6. OTORGAR EL ROL AL USUARIO
--------------------------------------------------------------
GRANT C##ACCESO_OBJETOS TO C##SISE_CO;

--------------------------------------------------------------
-- 7. ELIMINAR EL ROL
--------------------------------------------------------------
DROP ROLE C##ACCESO_OBJETOS;

--------------------------------------------------------------
-- 8. ELIMINAR USUARIOS
--------------------------------------------------------------
DROP USER C##SISE_SM CASCADE;  
-- CASCADE elimina todos sus objetos

--------------------------------------------------------------
-- 9. REVOCAR PERMISOS (QUITAR PRIVILEGIOS)
--------------------------------------------------------------
REVOKE CREATE SESSION FROM C##SISE_CO;
REVOKE CREATE TABLE FROM C##SISE_CO;
REVOKE CREATE PROCEDURE FROM C##SISE_CO;
REVOKE CREATE TRIGGER FROM C##SISE_CO;
REVOKE CREATE VIEW FROM C##SISE_CO;
REVOKE CREATE USER FROM C##SISE_CO;

--------------------------------------------------------------
-- 10. CONSULTAR PRIVILEGIOS ASIGNADOS
--------------------------------------------------------------
SELECT * FROM DBA_SYS_PRIVS 
WHERE GRANTEE = 'C##SISE_CO';
