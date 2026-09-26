# Trabajo Final de Máster — Participación en Carreras Populares en España

Trabajo Final de Máster (Data Analyst) sobre la participación en carreras
populares en España (running, ciclismo, natación, triatlón y modalidades
similares). El proyecto cubre el ciclo completo de un caso de analítica de
datos: recopilación y limpieza de datos, análisis exploratorio, un modelo
predictivo de finishers y un dashboard en Power BI.

**Autora:** Clàudia Rafart Medina

## Estructura del repositorio

```
TFM/
├── data/
│   ├── raw/            # Datos tal como se descargan de cada fuente (NO versionado)
│   ├── processed/
│   │   ├── <fuente>/   # Datos limpios por fuente, a nivel de carrera individual (NO versionado)
│   │   ├── INE/         # Datos de población del INE ya procesados
│   │   └── union/       # Dataset final agregado (una fila por edición de carrera)
├── notebooks/
│   ├── scraping/        # Un notebook por fuente para descargar los datos
│   ├── limpieza/        # Limpieza y normalización por fuente + unión final
│   └── analisis/        # EDA, tratamiento de outliers y modelo predictivo
├── memoria/              # Borradores y documentación de la memoria del TFM
└── .gitignore
```

## Datos

Los datos en `data/raw/` y en `data/processed/<fuente>/` **no están
versionados** en este repositorio, por dos motivos:

1. **Privacidad**: son resultados individuales de participantes (nombre,
   dorsal, tiempo, categoría) tal como se obtienen de cada web de
   cronometraje, antes de agregarse.
2. **Tamaño**: en conjunto ocupan varios cientos de MB, y algún fichero
   individual supera el límite de 100 MB de GitHub.

El dataset final en `data/processed/union/` sí está versionado: es el
resultado de agregar todas las fuentes a nivel de **edición de carrera**
(no de participante individual), y es el que alimenta el modelo y el
dashboard.

### Fuentes de datos

RaceResult, MyChip, Championchip, CCNorte, CronoRunner, CronoFinisher,
Cruzando la Meta, Carreiras Galegas, Buscametas, CursesCAT, Iter5,
TimingSys, YouEvent y Sportmaniacs, más los datos de población municipal
del INE para cruzar cobertura geográfica. (La fuente RaceResult tiene
notebooks de scraping/limpieza pero, por problemas recurrentes de
extracción, actualmente no está integrada en la unión final.)

### Cómo reproducir los datos desde cero

1. Ejecutar los notebooks de `notebooks/scraping/` (uno por fuente) para
   descargar los datos en `data/raw/`.
2. Ejecutar los notebooks de `notebooks/limpieza/` correspondientes a cada
   fuente para generar `data/processed/<fuente>/`.
3. Ejecutar `notebooks/limpieza/Limpieza_union.ipynb` para generar el
   dataset agregado final en `data/processed/union/`.
4. Ejecutar `notebooks/analisis/Limpieza_outliers.ipynb` para la versión
   sin outliers, y `notebooks/analisis/Modelo_finishers.ipynb` para el
   modelo predictivo.

## Modelo

`notebooks/analisis/Modelo_finishers.ipynb` entrena un modelo (Random
Forest) para estimar el número de finishers de una edición de carrera a
partir de variables geográficas, de historial y de carreras cercanas
(`carreras_radio_25km`), entre otras.

## Dashboard (Power BI)

El dashboard organiza el análisis en seis páginas: Visió general,
Geografia, Modalitat i públic, Estacionalitat, Evolució participació
femenina y Resultats del model. El archivo `.pbix` se gestiona fuera de
este repositorio.

## Estado actual

- EDA y limpieza de las fuentes: completado.
- Dataset agregado y modelo de finishers: completado, en iteración.
- Dashboard de Power BI: en desarrollo.
- Memoria: en redacción (ver `memoria/`).
