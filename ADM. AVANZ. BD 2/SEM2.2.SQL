-- OPERADORES DE CONJUNTOS
-- Permiten combinar los resultados de dos consultas SELECT.
-- Los SELECT deben tener la misma cantidad de columnas y tipos de datos compatibles.

-- UNION: Combina los resultados y elimina los datos duplicados.
-- UNION ALL: Combina los resultados y conserva los datos duplicados.
-- INTERSECT: Muestra los datos que existen en ambos resultados.
-- MINUS: Muestra los datos del primer SELECT que no existen en el segundo.

-- UNION: ELIMINA DATOS DUPLICADOS Y OCASIONA ERRORES SI SON DE DIFERENTES TIPO DE DATOS Y DIFERENTE ORDEN 
select 'GATO' as animales
  from dual
union
select 'GATO'
  from dual;

-- UNION ALL: NO ELIMINA DATOS REPETIDOS
select 'GATO' as animales
  from dual
union all
select 'GATO'
  from dual;

-- INTERSECT: MUESTA SI TIENEN DATOS IGUALES, PARECIO A UN JOIN, SINO VACIO
select 'SOL' as animales
  from dual
intersect
select 'ESTRELLA'
  from dual;

-- MINUS: MUESTRA EL PRIMER SELECT SI SON DIFERENTES, SI SON IGUALES VACIO
select 'SOL' as objeto
  from dual
minus
select 'LUNA'
  from dual;