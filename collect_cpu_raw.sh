#!/bin/bash
# collect_cpu_raw.sh
# Usage: ./collect_cpu_raw.sh [durée_en_secondes] [fichier_sortie]
# Exemple: ./collect_cpu_raw.sh 60 cpu_raw.csv

DURATION=${1:-10}          # durée par défaut : 10 secondes
OUTPUT=${2:-cpu_raw.csv}   # fichier de sortie par défaut

# Écrire l'en-tête du CSV
echo "timestamp,usage_percent" > "$OUTPUT"

# Fonction pour lire les temps CPU totaux (ligne "cpu")
get_cpu_times() {
    awk '/^cpu / {print $2, $3, $4, $5, $6, $7, $8}' /proc/stat
}

# Première lecture
read -r user_prev nice_prev system_prev idle_prev iowait_prev irq_prev softirq_prev <<< $(get_cpu_times)

for ((i=1; i<=DURATION; i++)); do
    sleep 1
    read -r user_cur nice_cur system_cur idle_cur iowait_cur irq_cur softirq_cur <<< $(get_cpu_times)

    # Calcul des différences
    user=$((user_cur - user_prev))
    nice=$((nice_cur - nice_prev))
    system=$((system_cur - system_prev))
    idle=$((idle_cur - idle_prev))
    iowait=$((iowait_cur - iowait_prev))
    irq=$((irq_cur - irq_prev))
    softirq=$((softirq_cur - softirq_prev))

    total=$((user + nice + system + idle + iowait + irq + softirq))
    usage=$(echo "scale=2; 100 * ($total - $idle) / $total" | bc)

    # Timestamp actuel
    timestamp=$(date +%s)

    # Ajout au fichier CSV
    echo "$timestamp,$usage" >> "$OUTPUT"

    # Mise à jour des valeurs précédentes
    user_prev=$user_cur; nice_prev=$nice_cur; system_prev=$system_cur
    idle_prev=$idle_cur; iowait_prev=$iowait_cur; irq_prev=$irq_cur
    softirq_prev=$softirq_cur
done

echo "Données brutes enregistrées dans $OUTPUT"
