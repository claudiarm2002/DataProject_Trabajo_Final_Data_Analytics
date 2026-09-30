#!/bin/bash
LIMPIEZA_DIR=/Users/claudiarm2002/Desktop/TFM/notebooks/limpieza
ANALISIS_DIR=/Users/claudiarm2002/Desktop/TFM/notebooks/analisis
LOG_DIR="$LIMPIEZA_DIR/_run_logs"
mkdir -p "$LOG_DIR"

run_nb() {
  local dir="$1" nb="$2"
  echo "=== $(date '+%H:%M:%S') INICI $nb ===" | tee -a "$LOG_DIR/_summary.log"
  ( cd "$dir" && jupyter nbconvert --to notebook --execute --inplace \
      --ExecutePreprocessor.kernel_name=python3 \
      --ExecutePreprocessor.timeout=-1 \
      "$nb" ) > "$LOG_DIR/${nb%.ipynb}.log" 2>&1
  status=$?
  echo "=== $(date '+%H:%M:%S') FI $nb (exit=$status) ===" | tee -a "$LOG_DIR/_summary.log"
  return $status
}

# 1. INE (necesario para Limpieza_union.ipynb)
run_nb "$LIMPIEZA_DIR" "Limpieza_INE.ipynb"

# 2. Fuentes individuales (orden indiferente entre sí)
for nb in \
  Limpieza_ITER5.ipynb \
  Limpieza_buscametas.ipynb \
  Limpieza_carreirasgalegas.ipynb \
  Limpieza_ccnorte.ipynb \
  Limpieza_cronofinisher.ipynb \
  Limpieza_cronorunner.ipynb \
  Limpieza_cruzandolameta.ipynb \
  Limpieza_cursescat.ipynb \
  Limpieza_mychip.ipynb \
  Limpieza_raceresult.ipynb \
  Limpieza_sportmaniacs.ipynb \
  Limpieza_championchip.ipynb \
  Limpieza_youevent.ipynb \
; do
  run_nb "$LIMPIEZA_DIR" "$nb"
done

# 3. Unión + outliers + EDA (en notebooks/analisis)
run_nb "$ANALISIS_DIR" "Limpieza_union.ipynb"
run_nb "$ANALISIS_DIR" "Limpieza_outliers.ipynb"
run_nb "$ANALISIS_DIR" "Analisis_union.ipynb"

echo "=== TOT FET $(date '+%H:%M:%S') ===" | tee -a "$LOG_DIR/_summary.log"
