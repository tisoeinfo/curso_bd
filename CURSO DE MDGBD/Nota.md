# ORDEN CORRECTO DE APLICAR CLAUSULAS SQL
- SELECT    =>  Especifica las columnas o los valores que quieres recuperar.
- FROM      => Especifica las tablas o vistas desde las cuales se van a obtener los datos.
- JOIN      => (si es necesario) Especifica las uniones (joins) entre varias tablas, si se están combinando datos de varias fuentes.
- WHERE     => Filtra las filas antes de cualquier agrupamiento o cálculo de funciones agregadas.
- GROUP BY  => Agrupa las filas de la consulta en función de una o más columnas, comúnmente utilizado con funciones agregadas (SUM, COUNT, AVG, etc.).
- HAVING    => Filtra los resultados después de que se haya hecho el agrupamiento. Se usa para aplicar condiciones a los grupos creados por el GROUP BY.
- ORDER BY  => Ordena los resultados de la consulta según una o más columnas, en orden ascendente o descendente.

# Agregar campos a una tabla que ya fue creada
- ALTER TABLE meseros add direccion VARCHAR(50);

# Para cambiar tipos de datos
- ALTER TABLE turnos alter column nombre_turno VARCHAR(50);

# Comandos de apoyo
- Para ver tablas: EXEC sp_help MESEROS;
- Para ver procedimientos almacenados : EXEC sp_helptext 'SP_INSERTAR_MESEROS';
