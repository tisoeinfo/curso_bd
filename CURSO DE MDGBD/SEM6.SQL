CREATE PROCEDURE SP_SALUDOS
AS
	PRINT 'HOLA, BIENVENIDOS A TRANSACT/SQL'
;
EXEC SP_SALUDOS;

------------------------------------------------------------------------------------
CREATE PROCEDURE SP_DATOS_MESERO
@ID INT 
AS
PRINT 'ANTES';
	SELECT NOMBRE, APE_PATERNO, APE_MATERNO FROM MESEROS;
PRINT 'DESPUES';
;
EXECUTE SP_DATOS_MESERO 1;
DROP PROCEDURE SP_DATOS_MESERO;

------------------------------------------------------------------------------------
CREATE PROCEDURE SP_INSERTAR_MESEROS
@id_mesero int, 
@nombre varchar(50),
@ape_paterno varchar(50),
@ape_materno varchar(50),
@id_turno int
AS
 BEGIN
      -- PRINT 'TODO OK, LISTO PARA INGRESA EL INSERT';
	  INSERT INTO meseros (id_mesero,nombre, ape_paterno, ape_materno, id_turno) values (@id_mesero, @nombre, @ape_paterno, @ape_materno, @id_turno)
 END;
;

------------------------------------------------------------------------------------
-- COMANDOS QUE PUEDEN SERVIRTE
DROP PROCEDURE SP_INSERTAR_MESEROS;
SP_HELPTEXT 'SP_INSERTAR_MESEROS'; -- Y LUEGO PUEDES APLICAR UN ALTER PROCEDURE
EXEC SP_INSERTAR_MESEROS 6, 'JUAN', 'LOPEZ', 'MINAYA', 2;
