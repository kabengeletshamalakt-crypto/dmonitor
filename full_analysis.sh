#!/bin/bash
# full_analysis.sh
# Usage: ./full_analysis.sh [durée] [fichier_brut] [fichier_stats]

DURATION=${1:-10}
RAW_FILE=${2:-cpu_raw.csv}
STATS_FILE=${3:-cpu_stats.csv}

# Collecte
./collect_cpu_raw.sh "$DURATION" "$RAW_FILE"

# Analyse
./stats_to_csv.sh "$RAW_FILE" "$STATS_FILE"

echo "Analyse terminée. Données brutes : $RAW_FILE, statistiques : $STATS_FILE"
