#!/bin/bash
cd /Users/claudiarm2002/Desktop/TFM/notebooks/scraping
NOTEBOOKS=(
  scrape_buscametas.ipynb
  scrape_carreirasgalegas.ipynb
  scrape_cronofinisher.ipynb
  scrape_cruzandolameta.ipynb
  scrape_cronorunner.ipynb
  scrape_mychip.ipynb
  scrape_ccnorte.ipynb
  scrape_raceresult.ipynb
  scrape_sportmaniacs.ipynb
  scrape_youevent.ipynb
)
for nb in "${NOTEBOOKS[@]}"; do
  echo "=== $(date '+%H:%M:%S') INICI $nb ===" | tee -a _run_logs/_summary.log
  jupyter nbconvert --to notebook --execute --inplace \
    --ExecutePreprocessor.kernel_name=python3 \
    --ExecutePreprocessor.timeout=-1 \
    "$nb" > "_run_logs/${nb%.ipynb}.log" 2>&1
  status=$?
  echo "=== $(date '+%H:%M:%S') FI $nb (exit=$status) ===" | tee -a _run_logs/_summary.log
done
echo "=== TOT FET $(date '+%H:%M:%S') ===" | tee -a _run_logs/_summary.log
