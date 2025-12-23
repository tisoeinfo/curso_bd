# ¿Qué son las colecciones en PL/SQL?
Las colecciones en PL/SQL son estructuras de datos que permiten almacenar múltiples valores bajo una sola variable, de forma similar a los arreglos o listas en lenguajes de programación como Java, C# o JavaScript.

# Se utilizan cuando se necesita:
- Manejar varios registros al mismo tiempo
- Procesar datos en memoria
- Validar conjuntos de datos
- Optimizar el acceso a la base de datos

* Las colecciones NO son tablas físicas, existen solo mientras se ejecuta el bloque PL/SQL.
# -------------------------------------------------------------------------------

# Tipos de colecciones en Oracle
Oracle soporta tres tipos de colecciones:

# 1. ASSOCIATIVE ARRAY (Index-by Table)
- Es la más usada en PL/SQL
- Usa INDEX BY
- El índice lo controla el programador

* Características:
- Índices no tienen que ser consecutivos
- Vive solo en PL/SQL
- Ideal para lógica y validaciones
# ----------------------------------------
# 2. NESTED TABLE
- No usa INDEX BY
- El índice lo maneja Oracle
- Se parece a una lista dinámica

* Características:
- Índices automáticos (1, 2, 3…)
- Puede almacenarse en tablas
- Más estructurada que associative array
# ----------------------------------------
# 3. VARRAY (Variable Array)
- Tamaño máximo definido
- Índices automáticos
- Ideal cuando el número de elementos es fijo

* Características:
- Tamaño limitado
- Más controlado
- Útil para catálogos pequeños
# # --------------------------------------------------------------------------------
# RESUMEN 
En Oracle, las colecciones permiten trabajar con varios datos en memoria.
Dependiendo de la necesidad, podemos usar colecciones indexadas, listas dinámicas o arreglos de tamaño fijo.