-- MI tabla usuarios
CREATE TABLE usuarios (
    id_usuario NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    rol VARCHAR2(50)
);

--la tabla trabajadores
CREATE TABLE trabajadores (
    id_trabajador NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    cargo VARCHAR2(50),
    departamento VARCHAR2(50)
);

-- la tabla conceptos
CREATE TABLE conceptos (
    id_concepto NUMBER PRIMARY KEY,
    nombre_concepto VARCHAR2(50) NOT NULL,
    descripcion VARCHAR2(200)
);

-- la tabla viaticos
CREATE TABLE viaticos (
    id_viatico NUMBER PRIMARY KEY,
    id_trabajador NUMBER NOT NULL,
    id_usuario NUMBER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    monto_total NUMBER(10,2),
    FOREIGN KEY (id_trabajador) REFERENCES trabajadores(id_trabajador),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- la tabla detalle_viaticos
CREATE TABLE detalle_viaticos (
    id_detalle NUMBER PRIMARY KEY,
    id_viatico NUMBER NOT NULL,
    id_concepto NUMBER NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    FOREIGN KEY (id_viatico) REFERENCES viaticos(id_viatico),
    FOREIGN KEY (id_concepto) REFERENCES conceptos(id_concepto)
);


-- Insertar usuarios
INSERT INTO usuarios (id_usuario, nombre, email, rol)
VALUES (1, 'Ana Perez', 'ana.perez@email.com', 'Administrador');

INSERT INTO usuarios (id_usuario, nombre, email, rol)
VALUES (2, 'Carlos Gomez', 'carlos.gomez@email.com', 'Supervisor');

-- Insertar trabajadores
INSERT INTO trabajadores (id_trabajador, nombre, cargo, departamento)
VALUES (1, 'Luis Martinez', 'Ingeniero', 'Proyectos');

INSERT INTO trabajadores (id_trabajador, nombre, cargo, departamento)
VALUES (2, 'María López', 'Analista', 'Finanzas');

-- Insertar conceptos
INSERT INTO conceptos (id_concepto, nombre_concepto, descripcion)
VALUES (1, 'Hospedaje', 'Gastos de hotel y alojamiento');

INSERT INTO conceptos (id_concepto, nombre_concepto, descripcion)
VALUES (2, 'Alimentación', 'Gastos de comida');

INSERT INTO conceptos (id_concepto, nombre_concepto, descripcion)
VALUES (3, 'Transporte', 'Taxi, avión, bus');

-- Insertar viáticos
INSERT INTO viaticos (id_viatico, id_trabajador, id_usuario, fecha_inicio, fecha_fin, monto_total)
VALUES (1, 1, 2, TO_DATE('2025-12-20','YYYY-MM-DD'), TO_DATE('2025-12-21','YYYY-MM-DD'), 3000);

-- Insertar detalle_viaticos
INSERT INTO detalle_viaticos (id_detalle, id_viatico, id_concepto, monto)
VALUES (1, 1, 1, 1500);

INSERT INTO detalle_viaticos (id_detalle, id_viatico, id_concepto, monto)
VALUES (2, 1, 2, 1000);

INSERT INTO detalle_viaticos (id_detalle, id_viatico, id_concepto, monto)
VALUES (3, 1, 3, 500);
COMMIT;

--cree una Vista para que me liste estos datos
CREATE VIEW view_viaticos_lista AS
SELECT 
    v.id_viatico,
    t.nombre AS trabajador,
    u.nombre AS asignado_por,
    v.fecha_inicio,
    v.fecha_fin,
    c.nombre_concepto,
    dv.monto
FROM viaticos v
JOIN trabajadores t ON v.id_trabajador = t.id_trabajador
JOIN usuarios u ON v.id_usuario = u.id_usuario
JOIN detalle_viaticos dv ON v.id_viatico = dv.id_viatico
JOIN conceptos c ON dv.id_concepto = c.id_concepto;

SELECT * FROM view_viaticos_lista;

--cree otra vista con funciones logicas
CREATE VIEW view_viaticostotalxtrabajador AS
SELECT 
    t.id_trabajador,
    t.nombre AS trabajador,
    COUNT(v.id_viatico) AS cantidad_viaticos,
    SUM(v.monto_total) AS monto_total_viaticos
FROM trabajadores t
LEFT JOIN viaticos v ON t.id_trabajador = v.id_trabajador
GROUP BY t.id_trabajador, t.nombre;

SELECT * FROM view_viaticostotalxtrabajador;


