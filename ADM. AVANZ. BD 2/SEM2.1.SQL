-- ### Introducción a Tablespaces y Datafiles
-- Antes: Trabajabas con los objetos de Oracle (tablas, índices, etc.)
-- sin preocuparte directamente por su almacenamiento físico.

-- Después: Aprendes a controlar y organizar el almacenamiento de esos objetos
-- mediante TABLESPACES y DATAFILES.

-- TABLESPACE = espacio lógico donde Oracle organiza el almacenamiento de los objetos.
-- DATAFILE   = archivo físico donde Oracle almacena realmente la información.

-- Relación:
-- TABLA -> TABLESPACE -> DATAFILE (.dbf) -> DISCO

-- ### Sintaxis
create tablespace mi_tablespace  -- Se está creando un tablespace llamado mi_tablespace.
   datafile 'D:\OracleXE21\oradata\XE\mi_tablespace.dbf' -- Se especifica el archivo físico donde se almacenará el tablespace.
    size 100M -- Define el tamaño inicial del archivo de datos (mi_tablespace.dbf).
   autoextend on -- Permite que el datafile crezca automáticamente cuando se llene el espacio disponible. (Si no se activa AUTOEXTEND, el archivo se quedaría con el tamaño fijo de 100MB, y cuando se llene, las operaciones que requieran más espacio fallarían.)
    next 10M -- Define el incremento de crecimiento del archivo cada vez que se llene. (En este caso, cuando los 100MB iniciales se agoten, Oracle agregará 10MB más al archivo automáticamente.)
    maxsize 500M -- Especifica el límite máximo al que puede crecer el archivo. (En este ejemplo, el archivo puede crecer hasta 500MB como máximo.)


-- ### Practica 1:
-- Paso 1, nos conectamos con el usuario SYSTEM desde SQL Developer.
-- Paso 2, ver la sesion actual del contenedor de la BD
SHOW CON_NAME; 
-- Paso 3, si esta en CDB$ROOT lo cambios al contenedor que vamos a trabajar, en este caso sera XEPDB1:
alter session set container = xepdb1;
-- Paso 4, creamos el TABLESPACE
-- Ruta recomendada para este entorno: C:\app\USER\product\21c\oradata\XE
-- La ruta puede variar según la instalación.
create tablespace mi_tablespace
   datafile 'C:\app\USER\product\21c\oradata\XE\mi_tablespace.dbf' size 100M
   autoextend on next 10M maxsize 500M;
-- Paso 5, creamos el usuario y lo asignamos al TABLESPACE que creamos:
create user usuario_tablespace identified by "123"
   default tablespace mi_tablespace;
-- Paso 6, le asignamos permisos como DBA como si fuera un usuario normal:
grant dba to usuario_tablespace; 
-- Paso 7, nos conectamos con el usuario creado  desde SQL Developer
-- 1. Username: USUARIO_TABLESPACE
-- 2. Password: 123
-- 3. Hostname: localhost (o el IP de tu servidor Oracle)
-- 4. Port: 1521 (por defecto)
-- 5. Service Name: XEPDB1 (no utilizar XE ni CDB$ROOT)
-- Paso 8, creamos una tabla en el TABLESPACE
create table mi_tabla (
   id     number primary key,
   nombre varchar2(50)
);
-- Validamos que la tabla este en su tablespace, el campo owner es sencible a MAYUSCULAS
select table_name,
       tablespace_name
  from dba_tables
 where owner = 'USUARIO_TABLESPACE';
-- Validamos que usuario fueron creados en los tablespace, el campo username es sencible a MAYUSCULAS
select username,
       default_tablespace
  from dba_users
 where username = 'USUARIO_TABLESPACE';
-- Como ver donde se encuentran los tablespace de mi ORACLE
select *
  from dba_tablespaces;
-- Por si se desea eliminar el TABLESPACE
drop tablespace mi_tablespace including contents and datafiles;

-- ### Practica 2:
-- Paso 1, nos conectamos con el usuario SYSTEM desde SQL Developer.
-- Paso 2, ver la sesion actual del contenedor de la BD:
SHOW CON_NAME; 
-- Paso 3, si esta en XEPDB1 lo cambios al contenedor que vamos a trabajar, en este caso sera CDB$ROOT:
alter session set container = cdb$root; 
-- Paso 4, creamos el usuario con prefijo
create user c##usuario_con_prefijo identified by "123";
-- Paso 5, le asignamos permisos como DBA como si fuera un usuario normal:
grant dba to c##usuario_con_prefijo;
-- Paso 6, Validamos que usuario fueron creados en los tablespace, el campo username es sencible a MAYUSCULAS, en este caso todos se almacenan en  el
-- TABLESPACE: USERS
select username,
       default_tablespace
  from dba_users
 where username = 'C##USUARIO_CON_PREFIJO'; 
-- Paso 7, repetir lo que esta en la Practica 1