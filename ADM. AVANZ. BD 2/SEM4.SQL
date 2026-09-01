-- ¿Que es SQL Tuning Advisor?
-- Es una herramienta de Oracle para analizar y optimizar consultas SQL. Su objetivo es mejorar el rendimiento 
-- de las consultas identificando índices, estadísticas y cambios en el código SQL que pueden hacer que una consulta 
-- se ejecute más rápido.

-- ¿Cómo funciona SQL Tuning Advisor?
-- Analiza una consulta SQL y detecta posibles problemas de rendimiento.
-- Genera recomendaciones como:
-- Crear o modificar índices.
-- Reescribir la consulta para mejorar su eficiencia.
-- Actualizar estadísticas para que el optimizador de Oracle tome mejores decisiones.
-- Puedes aplicar las recomendaciones automáticamente o revisarlas antes de ejecutarlas.

-- Abrir SQL Tuning Advisor:
-- Si tienes Oracle Enterprise Edition → Necesitas comprar la licencia del Tuning Pack para activarlo.
-- ##################################################################################################################

-- Alternativa gratuita (Usar el usuario System u otro usuario creado por ti)

DROP TABLE movimientos_bancarios;

CREATE TABLE movimientos_bancarios (
    id NUMBER PRIMARY KEY, 
    numero_transaccion VARCHAR2(20), 
    tipo_transaccion VARCHAR2(20), 
    monto NUMBER(10,2),
    fecha_transaccion DATE,
    cuenta_origen VARCHAR2(20),
    cuenta_destino VARCHAR2(20)
);

-- Insertamos 50 millones de registros
BEGIN
    FOR i IN 1..50000000 LOOP
        INSERT INTO movimientos_bancarios (id, numero_transaccion, tipo_transaccion, monto, fecha_transaccion, cuenta_origen, cuenta_destino)
        VALUES (
            i, 
            'TRX' || i,  
            'Depósito',  
            1000,  
            DATE '2020-01-01',  
            'C' || i,  
            'C' || (i + 1)  
        );
    END LOOP;
    COMMIT;
END;

-- Validamos si se insertaron los 5 millones de registros
SELECT COUNT(1) FROM movimientos_bancarios;

-- Validamos cuanto demora
SELECT * FROM movimientos_bancarios WHERE numero_transaccion = 'TRX500000';

-- Validamos tambien el plan de ejecución
EXPLAIN PLAN FOR SELECT * FROM movimientos_bancarios WHERE numero_transaccion = 'TRX500000';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Creamos el INDICE
CREATE INDEX idx_numero_transaccion ON movimientos_bancarios(numero_transaccion);

-- Volvemos a validar 
SELECT * FROM movimientos_bancarios WHERE numero_transaccion = 'TRX500000';

-- Y volvemos a validar el plan de ejecución
EXPLAIN PLAN FOR SELECT * FROM movimientos_bancarios WHERE numero_transaccion = 'TRX500000';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 📍 Antes del índice:
-- Oracle busca en toda la tabla:  
-- 1 → TRX0001  
-- 2 → TRX0002  
-- 3 → TRX0003  ✅  
-- 4 → TRX0004  
-- 5 → TRX0005  
------------------------------------------------------------
-- 📍 Después del índice:
-- Índice (IDX_NUMERO_TRANSACCION):  
-- 'TRX0001' → ROWID: X1  
-- 'TRX0002' → ROWID: X2  
-- 'TRX0003' → ROWID: X3  ✅  
-- 'TRX0004' → ROWID: X4  
-- 'TRX0005' → ROWID: X5  