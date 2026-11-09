-- GreenThumb Hub: las mismas cinco consultas del informe
-- Ejecutar despues de greenthumb_hub.sql
-- GREENTHUMB HUB | Consultas del informe
-- Ejecutar DESPUES de greenthumb_hub.sql (o despues de crear e insertar datos).
USE greenthumb_hub;

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
