<p align="center">
  <img src="./logo_unl.png" alt="Logo de la Universidad Nacional de Loja" width="230">
</p>
<h1 align="center">INFORME DE FIN DE UNIDAD</h1>
<h2 align="center">GreenThumb Hub: Sistema de Control de Plantas, Riego y Cuidados Domésticos</h2>
<p align="center"><strong>FEIRNNR - Carrera de Computación</strong></p>

---

## Datos Generales

| Información | Detalle |
|---|---|
| **Asignatura** | Base de Datos |
| **Ciclo** | 3 A |
| **Unidad** | 1 |
| **Docente** | Edwin René Guamán Quinche |
| **Estudiante** | Elian Vicente Jiménez Motoche |
| **Fecha** | 09/11/2026 |

### Resultado de aprendizaje de la unidad

Modelar bases de datos de problemas reales, bajo los principios de solidaridad, transparencia, responsabilidad y honestidad.

---

## Índice

1. [Título](#1-título)
2. [Contexto del problema](#2-contexto-del-problema)
3. [Objetivos](#3-objetivos)
4. [Modelos conceptuales de bases de datos](#4-modelos-conceptuales-de-bases-de-datos)
5. [Código SQL](#5-código-sql)
6. [Consultas de álgebra relacional y SQL](#6-consultas-de-álgebra-relacional-y-sql)
7. [Conclusiones](#7-conclusiones)
8. [Bibliografía](#8-bibliografía)

---

## 1. Título

**GreenThumb Hub: Sistema de Control de Plantas, Riego y Cuidados Domésticos**

## 2. Contexto del problema

En los hogares y jardines donde se tienen varias plantas es común olvidar cuándo se regó una planta, qué tipo de luz necesita o cuándo debe recibir otro cuidado. Muchas veces estos datos se llevan en notas sueltas o simplemente se recuerdan de memoria. Esto puede causar descuidos y dificultar el seguimiento de cada planta.

GreenThumb Hub busca resolver este problema con una base de datos donde se registran las especies, las ubicaciones, las plantas y los cuidados realizados. También permite programar tareas como riego, poda y fertilización. Las recomendaciones de luz y mantenimiento pueden variar según la especie y las condiciones del lugar [4], [5].

## 3. Objetivos

### 3.1. Objetivo General

Diseñar una base de datos para organizar la información de las plantas de un hogar o jardín, sus ubicaciones y los cuidados que reciben, usando el modelo Entidad–Relación y SQL.

### 3.2. Objetivos Específicos

- Elaborar el modelo Entidad–Relación y convertirlo en tablas relacionadas mediante claves primarias y foráneas.
- Crear las tablas e ingresar datos de ejemplo en MySQL para realizar consultas sobre plantas, ubicaciones y cuidados.

---

## 4. Modelos conceptuales de bases de datos

### 4.1. Modelo Entidad-Relación (E-R)

El siguiente diagrama muestra las cinco entidades principales, sus atributos y las relaciones entre ellas. Los rectángulos representan entidades, los óvalos atributos y los rombos relaciones [1].

<p align="center">
  <img src="./modelo_entidad_relacion.png" alt="Diagrama entidad-relación GreenThumb Hub" width="95%">
</p>

<p align="center"><em>Figura 1. Diagrama Entidad–Relación del sistema GreenThumb Hub.</em></p>

**Entidades principales:** ESPECIE, UBICACION, PLANTA, TIPO_CUIDADO e HISTORIAL_CUIDADO.

**Relaciones:** una especie puede tener varias plantas, una ubicación puede contener varias plantas, y cada planta puede tener varios registros de cuidados. Una planta también puede tener varios tipos de cuidado programados.

### 4.2. Modelo Relacional

Al pasar el modelo E-R a tablas, se definen claves primarias (PK) para identificar registros y claves foráneas (FK) para relacionarlos [2]. Se añade `PROGRAMACION_CUIDADO` como tabla intermedia para guardar las tareas periódicas; por eso hay **cinco entidades conceptuales y seis tablas**.

#### 4.2.1. Tabla ESPECIE

| Atributo | Tipo de Dato | Tipo de Clave | Referencia (FK) |
|---|---|---|---|
| `id_especie` | INT | **PK** | — |
| `nombre_comun` | VARCHAR(80) | — | — |
| `nombre_cientifico` | VARCHAR(120) | — | — |
| `frecuencia_riego_dias` | INT | — | — |
| `luz_requerida` | VARCHAR(40) | — | — |

#### 4.2.2. Tabla UBICACION

| Atributo | Tipo de Dato | Tipo de Clave | Referencia (FK) |
|---|---|---|---|
| `id_ubicacion` | INT | **PK** | — |
| `nombre_lugar` | VARCHAR(80) | — | — |
| `condiciones_luz` | VARCHAR(40) | — | — |
| `humedad` | VARCHAR(30) | — | — |

#### 4.2.3. Tabla PLANTA

| Atributo | Tipo de Dato | Tipo de Clave | Referencia (FK) |
|---|---|---|---|
| `id_planta` | INT | **PK** | — |
| `id_especie` | INT | **FK** | ESPECIE(id_especie) |
| `id_ubicacion` | INT | **FK** | UBICACION(id_ubicacion) |
| `apodo` | VARCHAR(100) | — | — |
| `fecha_registro` | DATE | — | — |
| `estado` | VARCHAR(20) | — | — |

#### 4.2.4. Tabla TIPO_CUIDADO

| Atributo | Tipo de Dato | Tipo de Clave | Referencia (FK) |
|---|---|---|---|
| `id_tipo_cuidado` | INT | **PK** | — |
| `nombre_cuidado` | VARCHAR(80) | — | — |
| `descripcion` | VARCHAR(255) | — | — |

#### 4.2.5. Tabla HISTORIAL_CUIDADO

| Atributo | Tipo de Dato | Tipo de Clave | Referencia (FK) |
|---|---|---|---|
| `id_historial` | INT | **PK** | — |
| `id_planta` | INT | **FK** | PLANTA(id_planta) |
| `id_tipo_cuidado` | INT | **FK** | TIPO_CUIDADO(id_tipo_cuidado) |
| `fecha_realizacion` | DATE | — | — |
| `observaciones` | VARCHAR(255) | — | — |

#### 4.2.6. Tabla PROGRAMACION_CUIDADO

| Atributo | Tipo de Dato | Tipo de Clave | Referencia (FK) |
|---|---|---|---|
| `id_planta` | INT | **PK / FK** | PLANTA(id_planta) |
| `id_tipo_cuidado` | INT | **PK / FK** | TIPO_CUIDADO(id_tipo_cuidado) |
| `intervalo_dias` | INT | — | — |
| `fecha_proxima` | DATE | — | — |

### 4.3. Diagrama Relacional

<p align="center">
  <img src="./modelo_relacional.png" alt="Diagrama relacional GreenThumb Hub" width="95%">
</p>

<p align="center"><em>Figura 2. Diagrama relacional del sistema GreenThumb Hub.</em></p>

Los archivos editables del modelo se encuentran en [`modelo_entidad_relacion.drawio`](./modelo_entidad_relacion.drawio) y [`modelo_relacional.drawio`](./modelo_relacional.drawio).

---

## 5. Código SQL

El código se escribió para MySQL. `CREATE TABLE` permite crear las tablas y `INSERT INTO` permite ingresar datos de ejemplo [3]. Los archivos completos están en [`./greenthumb_hub.sql`](./greenthumb_hub.sql) y [`./consultas.sql`](./consultas.sql).

### 5.1. Creación de Tablas (DDL)

#### Tabla ESPECIE

```sql
CREATE TABLE ESPECIE (
  id_especie INT AUTO_INCREMENT PRIMARY KEY,
  nombre_comun VARCHAR(80) NOT NULL,
  nombre_cientifico VARCHAR(120),
  frecuencia_riego_dias INT NOT NULL,
  luz_requerida VARCHAR(40) NOT NULL,
  CONSTRAINT chk_frecuencia CHECK (frecuencia_riego_dias > 0)
);
```

#### Tabla UBICACION

```sql
CREATE TABLE UBICACION (
  id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
  nombre_lugar VARCHAR(80) NOT NULL UNIQUE,
  condiciones_luz VARCHAR(40) NOT NULL,
  humedad VARCHAR(30) NOT NULL DEFAULT 'Media'
);
```

#### Tabla PLANTA

```sql
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
```

### 5.2. Inserción de Datos (DML)

#### Inserción en la tabla ESPECIE

```sql
INSERT INTO ESPECIE (nombre_comun, nombre_cientifico, frecuencia_riego_dias, luz_requerida) VALUES
('Monstera','Monstera deliciosa',7,'Luz indirecta'),
('Suculenta','Echeveria elegans',14,'Luz directa'),
('Pothos','Epipremnum aureum',6,'Luz indirecta'),
('Lirio de paz','Spathiphyllum wallisii',5,'Sombra parcial'),
('Albahaca','Ocimum basilicum',2,'Luz directa'),
('Lengua de suegra','Dracaena trifasciata',12,'Luz indirecta');
```

#### Inserción en la tabla UBICACION

```sql
INSERT INTO UBICACION (nombre_lugar, condiciones_luz, humedad) VALUES
('Sala','Luz indirecta','Media'),
('Balcon','Luz directa','Baja'),
('Terraza','Luz directa','Media'),
('Dormitorio','Sombra parcial','Media'),
('Patio','Luz directa','Alta');
```

#### Inserción en la tabla PLANTA

```sql
INSERT INTO PLANTA (id_especie,id_ubicacion,apodo,fecha_registro,estado) VALUES
(1,1,'Costilla','2026-08-15','Activa'),
(2,2,'Roseta','2026-09-10','Activa'),
(3,1,'Enredadera','2026-07-03','Activa'),
(4,4,'Paz','2026-10-12','En observacion'),
(5,3,'Aroma','2026-10-02','Activa'),
(6,4,'Espada','2026-06-20','Activa'),
(1,5,'Monstera joven','2026-11-01','Activa'),
(3,1,'Pothos pequeno','2026-11-05','Activa');
```

> **Importante:** Para ejecutar el proyecto completo hay que usar el archivo `greenthumb_hub.sql`, porque crea también `TIPO_CUIDADO`, `HISTORIAL_CUIDADO` y `PROGRAMACION_CUIDADO` en el orden correcto.

---

## 6. Consultas de álgebra relacional y SQL

### 6.1. Consulta 1 — Selección (σ)

**Enunciado:** Mostrar las plantas que están en observación.

**Álgebra Relacional:**

```text
σ estado = "En observacion" (PLANTA)
```

**Consulta SQL:**

```sql
SELECT * FROM PLANTA WHERE estado = 'En observacion';
```

**Resultado esperado:** Aparece la planta llamada Paz.

---

### 6.2. Consulta 2 — Proyección (π) y producto cartesiano (×)

**Enunciado:** Mostrar todas las combinaciones posibles de especies y lugares disponibles.

**Álgebra Relacional:**

```text
π nombre_comun, nombre_lugar (ESPECIE × UBICACION)
```

**Consulta SQL:**

```sql
SELECT e.nombre_comun, u.nombre_lugar
FROM ESPECIE e CROSS JOIN UBICACION u;
```

**Resultado esperado:** 30 combinaciones de seis especies con cinco ubicaciones. Son posibilidades, no ubicaciones reales de las plantas.

---

### 6.3. Consulta 3 — Selección y proyección (σ + π)

**Enunciado:** Consultar las especies que tienen un riego sugerido de siete días o menos.

**Álgebra Relacional:**

```text
π nombre_comun, frecuencia_riego_dias (σ frecuencia_riego_dias <= 7 (ESPECIE))
```

**Consulta SQL:**

```sql
SELECT nombre_comun, frecuencia_riego_dias
FROM ESPECIE
WHERE frecuencia_riego_dias <= 7;
```

**Resultado esperado:** Monstera, Pothos, Lirio de paz y Albahaca.

---

### 6.4. Consulta 4 — Reunión / JOIN (⋈)

**Enunciado:** Mostrar el apodo y la especie de las plantas que están en la sala.

**Álgebra Relacional:**

```text
π apodo, nombre_comun, nombre_lugar (σ nombre_lugar = 'Sala' (PLANTA ⋈ ESPECIE ⋈ UBICACION))
```

**Consulta SQL:**

```sql
SELECT p.apodo, e.nombre_comun, u.nombre_lugar
FROM PLANTA p
JOIN ESPECIE e ON p.id_especie = e.id_especie
JOIN UBICACION u ON p.id_ubicacion = u.id_ubicacion
WHERE u.nombre_lugar = 'Sala';
```

**Resultado esperado:** Se muestran Costilla, Enredadera y Pothos pequeno con sus especies.

---

### 6.5. Consulta 5 — Agrupamiento y conteo (γ)

**Enunciado:** Identificar plantas con dos o más cuidados realizados.

**Álgebra Relacional (extendida):**

```text
R = γ id_planta, apodo; COUNT(id_historial) → total_cuidados (PLANTA ⋈ HISTORIAL_CUIDADO)
π apodo, total_cuidados (σ total_cuidados >= 2 (R))
```

**Consulta SQL:**

```sql
SELECT p.apodo, COUNT(h.id_historial) AS total_cuidados
FROM PLANTA p
JOIN HISTORIAL_CUIDADO h ON p.id_planta = h.id_planta
GROUP BY p.id_planta, p.apodo
HAVING COUNT(h.id_historial) >= 2;
```

**Resultado esperado:** Se muestran Costilla (3), Roseta (2), Enredadera (2), Paz (2) y Aroma (2).

---

## 7. Conclusiones

- El diagrama E-R permitió organizar la información de especies, plantas, ubicaciones y cuidados. También ayudó a entender las relaciones entre las entidades y cómo pasarlas a tablas.
- Al crear las tablas en SQL se comprendió la importancia de las claves primarias y foráneas. Los datos de prueba permitieron comprobar cómo se relacionan los registros de distintas tablas.
- Las consultas de álgebra relacional y SQL ayudaron a buscar plantas por su estado, ubicación y número de cuidados. Estas consultas serán útiles si en el futuro se desarrolla una aplicación para el proyecto.

---

## 8. Bibliografía

[1] P. P. Chen, “The Entity-Relationship Model—Toward a Unified View of Data,” *ACM Transactions on Database Systems*, vol. 1, no. 1, pp. 9–36, 1976. [doi:10.1145/320434.320440](https://doi.org/10.1145/320434.320440).

[2] E. F. Codd, “A Relational Model of Data for Large Shared Data Banks,” *Communications of the ACM*, vol. 13, no. 6, pp. 377–387, 1970. [doi:10.1145/362384.362685](https://doi.org/10.1145/362384.362685).

[3] Oracle, “CREATE TABLE Statement,” *MySQL 8.4 Reference Manual*. [En línea]. Disponible: https://dev.mysql.com/doc/refman/8.4/en/create-table.html.

[4] J. Weisenhorn y N. Hoidal, “Lighting for indoor plants and starting seeds,” *University of Minnesota Extension*. [En línea]. Disponible: https://extension.umn.edu/garden-and-home/yard-and-garden/gardening-in-minnesota/lighting-for-indoor-plants.

[5] R. Trott, “Spring houseplant care,” *University of Minnesota Extension*. [En línea]. Disponible: https://extension.umn.edu/garden-and-home/yard-and-garden/gardening-in-minnesota/houseplants/spring-houseplant-care.

---

