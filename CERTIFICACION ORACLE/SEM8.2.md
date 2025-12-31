# ¿Qué es SQL Dinámico en PL/SQL?
El SQL dinámico es una técnica de PL/SQL que permite construir y ejecutar sentencias SQL en tiempo de ejecución, es decir, cuando el programa ya se está ejecutando y no en el momento de compilación.

A diferencia del SQL estático, donde la sentencia es fija y conocida desde el inicio, en el SQL dinámico la sentencia se arma como texto (por ejemplo en una variable VARCHAR2) y luego se ejecuta.
# -------------------------------------------------------------------------------

# Diferencia clave: SQL estático vs SQL dinámico
- # SQL estático :
- La estructura del SQL es fija
- Solo cambian los valores (parámetros)
- Es más seguro y más eficiente
- Es el más usado en CRUDs

- # SQL dinámico
- La estructura del SQL cambia en tiempo de ejecución
- Puede cambiar la tabla, la columna o los filtros
- Se usa solo en casos especiales

# -------------------------------------------------------------------------------

# ¿Cuándo SÍ se usa SQL dinámico?
El SQL dinámico se utiliza cuando los parámetros no son suficientes, es decir, cuando no solo cambian los valores, sino la estructura del SQL.

- # Casos reales donde sí es necesario:
Cuando no se conoce el nombre de la tabla en tiempo de compilación
Cuando no se conoce la columna por la cual se va a filtrar
Cuando se construyen búsquedas avanzadas con filtros opcionales
En reportes dinámicos (columnas u ordenamientos variables)
En tareas de mantenimiento, auditoría o administración
En herramientas genéricas que trabajan con distintas tablas
Estos casos no se resuelven con SQL estático.
# -------------------------------------------------------------------------------

# ¿Cuándo NO se debe usar SQL dinámico?
- No se debe usar SQL dinámico cuando:
- El SQL es fijo
- Solo cambian los valores
- Se trata de un CRUD básico (INSERT, UPDATE, DELETE por ID)
- Ejemplo correcto (SQL estático):
- # DELETE FROM empleados_demo WHERE id_empleado = :id;
- Aquí no hay ninguna ventaja en usar SQL dinámico.