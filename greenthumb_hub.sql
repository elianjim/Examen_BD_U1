-- GREENTHUMB HUB | Base de datos completa
-- Modelo original: ESPECIE, UBICACION, PLANTA, TIPO_CUIDADO, HISTORIAL_CUIDADO.
-- PROGRAMACION_CUIDADO es la tabla intermedia de PLANTA <-> TIPO_CUIDADO.
-- Requiere MySQL 8.0.16+; ejecutar en una base nueva (no elimina datos existentes).

CREATE DATABASE IF NOT EXISTS greenthumb_hub CHARACTER SET utf8mb4;
USE greenthumb_hub;

CREATE TABLE ESPECIE (
  id_especie INT AUTO_INCREMENT PRIMARY KEY,
  nombre_comun VARCHAR(80) NOT NULL,
  nombre_cientifico VARCHAR(120),
  frecuencia_riego_dias INT NOT NULL,
  luz_requerida VARCHAR(40) NOT NULL,
  CONSTRAINT chk_frecuencia CHECK (frecuencia_riego_dias > 0)
);

CREATE TABLE UBICACION (
  id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
  nombre_lugar VARCHAR(80) NOT NULL UNIQUE,
  condiciones_luz VARCHAR(40) NOT NULL,
  humedad VARCHAR(30) NOT NULL DEFAULT 'Media'
);

CREATE TABLE TIPO_CUIDADO (
  id_tipo_cuidado INT AUTO_INCREMENT PRIMARY KEY,
  nombre_cuidado VARCHAR(80) NOT NULL UNIQUE,
  descripcion VARCHAR(255)
);

CREATE TABLE PLANTA (
  id_planta INT AUTO_INCREMENT PRIMARY KEY,
  id_especie INT NOT NULL,
  id_ubicacion INT NOT NULL,
  apodo VARCHAR(100) NOT NULL,
  fecha_registro DATE NOT NULL,
  estado VARCHAR(20) NOT NULL DEFAULT 'Activa',
  CONSTRAINT chk_estado CHECK (estado IN ('Activa','En observacion','Inactiva')),
  CONSTRAINT fk_planta_especie FOREIGN KEY (id_especie)
    REFERENCES ESPECIE(id_especie),
  CONSTRAINT fk_planta_ubicacion FOREIGN KEY (id_ubicacion)
    REFERENCES UBICACION(id_ubicacion)
);

CREATE TABLE HISTORIAL_CUIDADO (
  id_historial INT AUTO_INCREMENT PRIMARY KEY,
  id_planta INT NOT NULL,
  id_tipo_cuidado INT NOT NULL,
  fecha_realizacion DATE NOT NULL,
  observaciones VARCHAR(255),
  CONSTRAINT fk_hist_planta FOREIGN KEY (id_planta)
    REFERENCES PLANTA(id_planta),
  CONSTRAINT fk_hist_tipo FOREIGN KEY (id_tipo_cuidado)
    REFERENCES TIPO_CUIDADO(id_tipo_cuidado)
);

CREATE TABLE PROGRAMACION_CUIDADO (
  id_planta INT NOT NULL,
  id_tipo_cuidado INT NOT NULL,
  intervalo_dias INT NOT NULL,
  fecha_proxima DATE NOT NULL,
  PRIMARY KEY (id_planta, id_tipo_cuidado),
  CONSTRAINT chk_intervalo CHECK (intervalo_dias > 0),
  CONSTRAINT fk_prog_planta FOREIGN KEY (id_planta)
    REFERENCES PLANTA(id_planta),
  CONSTRAINT fk_prog_tipo FOREIGN KEY (id_tipo_cuidado)
    REFERENCES TIPO_CUIDADO(id_tipo_cuidado)
);

INSERT INTO ESPECIE (nombre_comun, nombre_cientifico, frecuencia_riego_dias, luz_requerida) VALUES
('Monstera','Monstera deliciosa',7,'Luz indirecta'),
('Suculenta','Echeveria elegans',14,'Luz directa'),
('Pothos','Epipremnum aureum',6,'Luz indirecta'),
('Lirio de paz','Spathiphyllum wallisii',5,'Sombra parcial'),
('Albahaca','Ocimum basilicum',2,'Luz directa'),
('Lengua de suegra','Dracaena trifasciata',12,'Luz indirecta');

INSERT INTO UBICACION (nombre_lugar, condiciones_luz, humedad) VALUES
('Sala','Luz indirecta','Media'),
('Balcon','Luz directa','Baja'),
('Terraza','Luz directa','Media'),
('Dormitorio','Sombra parcial','Media'),
('Patio','Luz directa','Alta');

INSERT INTO TIPO_CUIDADO (nombre_cuidado, descripcion) VALUES
('Riego','Aplicacion de agua segun necesidad'),
('Poda','Retiro de hojas o ramas deterioradas'),
('Fertilizacion','Aplicacion de nutrientes'),
('Cambio de maceta','Traslado a nuevo recipiente'),
('Limpieza de hojas','Retiro de polvo en las hojas');

INSERT INTO PLANTA (id_especie,id_ubicacion,apodo,fecha_registro,estado) VALUES
(1,1,'Costilla','2026-08-15','Activa'),
(2,2,'Roseta','2026-09-10','Activa'),
(3,1,'Enredadera','2026-07-03','Activa'),
(4,4,'Paz','2026-10-12','En observacion'),
(5,3,'Aroma','2026-10-02','Activa'),
(6,4,'Espada','2026-06-20','Activa'),
(1,5,'Monstera joven','2026-11-01','Activa'),
(3,1,'Pothos pequeno','2026-11-05','Activa');

INSERT INTO HISTORIAL_CUIDADO (id_planta,id_tipo_cuidado,fecha_realizacion,observaciones) VALUES
(1,1,'2026-11-03','Riego moderado'),
(1,3,'2026-10-20','Abono organico'),
(2,1,'2026-11-01','Sustrato humedecido'),
(3,1,'2026-11-05','Riego ligero'),
(3,3,'2026-11-02','Fertilizacion mensual'),
(4,1,'2026-11-06','Riego por sequedad del suelo'),
(4,5,'2026-11-02','Limpieza manual'),
(5,1,'2026-11-08','Riego por la manana'),
(5,2,'2026-11-04','Poda de hojas'),
(6,4,'2026-11-01','Se utilizo una maceta mayor'),
(2,3,'2026-10-25','Dosis reducida'),
(1,5,'2026-11-07','Hojas sin polvo');

INSERT INTO PROGRAMACION_CUIDADO (id_planta,id_tipo_cuidado,intervalo_dias,fecha_proxima) VALUES
(1,1,7,'2026-11-10'),
(1,3,30,'2026-11-19'),
(2,1,14,'2026-11-15'),
(3,1,6,'2026-11-11'),
(3,3,30,'2026-12-02'),
(4,1,5,'2026-11-11'),
(5,1,2,'2026-11-10'),
(5,2,21,'2026-11-25'),
(6,1,12,'2026-11-13'),
(7,1,7,'2026-11-14'),
(8,1,6,'2026-11-12');

-- CINCO CONSULTAS DEL INFORME
-- Consulta 1: seleccion
SELECT * FROM PLANTA WHERE estado = 'En observacion';

-- Consulta 2: producto cartesiano y proyeccion
SELECT e.nombre_comun, u.nombre_lugar
FROM ESPECIE e CROSS JOIN UBICACION u;

-- Consulta 3: seleccion y proyeccion
SELECT nombre_comun, frecuencia_riego_dias
FROM ESPECIE
WHERE frecuencia_riego_dias <= 7;

-- Consulta 4: JOIN de tres tablas
SELECT p.apodo, e.nombre_comun, u.nombre_lugar
FROM PLANTA p
JOIN ESPECIE e ON p.id_especie = e.id_especie
JOIN UBICACION u ON p.id_ubicacion = u.id_ubicacion
WHERE u.nombre_lugar = 'Sala';

-- Consulta 5: agrupacion y conteo
SELECT p.apodo, COUNT(h.id_historial) AS total_cuidados
FROM PLANTA p
JOIN HISTORIAL_CUIDADO h ON p.id_planta = h.id_planta
GROUP BY p.id_planta, p.apodo
HAVING COUNT(h.id_historial) >= 2;
