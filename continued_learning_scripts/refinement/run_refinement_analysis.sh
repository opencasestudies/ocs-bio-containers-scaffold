#!/bin/bash

echo "Extracting data"

mkdir -p ../../results/logs

Rscript ../../analysis_scripts/01_extract_data.R > ../../results/logs/data_extraction_logs.txt

echo "Wrangling data"

Rscript ../../analysis_scripts/02_wrangle.R > ../../results/logs/wrangling_logs.txt

echo "Visualizing data"

Rscript ../../analysis_scripts/03a_visualization.R > ../../results/logs/visualization_logs.txt

Rscript 03_alt_visualization_ggrepel.R >> ../../results/logs/visualization_logs.txt

echo "Analyzing data"

Rscript ../../analysis_scripts/04_analysis_metric.R > ../../results/logs/analysis_logs.txt

echo "Process complete"

Rscript -e "$(cat *.R | grep "library" | sort -u | xargs printf "%s; ") sessionInfo()" > ../../results/logs/session_info.txt
