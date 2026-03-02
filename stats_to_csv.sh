#!/bin/bash
# stats_to_csv.sh
# Usage: ./stats_to_csv.sh cpu_raw.csv [stats_output.csv]
# Calcule : moyenne, écart-type, médiane, min, max, 95e percentile

INPUT=${1:-cpu_raw.csv}
OUTPUT=${2:-cpu_stats.csv}

# Vérifier que le fichier d'entrée existe
if [ ! -f "$INPUT" ]; then
    echo "Erreur : fichier $INPUT introuvable."
    exit 1
fi

# Extraire la colonne usage (ignorer l'en-tête)
usage_values=$(tail -n +2 "$INPUT" | cut -d',' -f2)

# Compter le nombre de valeurs
n=$(echo "$usage_values" | wc -l)
if [ "$n" -eq 0 ]; then
    echo "Aucune donnée à analyser."
    exit 1
fi

# Calcul de la moyenne avec awk
mean=$(echo "$usage_values" | awk '{sum+=$1} END {print sum/NR}')

# Calcul de l'écart-type (population, biaisé)
std=$(echo "$usage_values" | awk -v mean="$mean" '{sumsq+=($1-mean)^2} END {print sqrt(sumsq/NR)}')

# Tri des valeurs pour médiane et centiles
sorted=$(echo "$usage_values" | sort -n)

# Minimum et maximum
min=$(echo "$sorted" | head -1)
max=$(echo "$sorted" | tail -1)

# Médiane (si n pair, moyenne des deux centrales)
median=$(echo "$sorted" | awk -v n="$n" '{
    a[NR]=$1
} END {
    if (n%2==1) print a[(n+1)/2]
    else print (a[n/2] + a[n/2+1])/2
}')

# 95e percentile (indice k = ceil(0.95 * n))
p95=$(echo "$sorted" | awk -v n="$n" '{
    a[NR]=$1
} END {
    k = int(0.95 * n + 0.999)  # arrondi supérieur
    print a[k]
}')

# Écrire les résultats dans un fichier CSV (une ligne)
echo "mean,std,median,min,max,p95" > "$OUTPUT"
echo "$mean,$std,$median,$min,$max,$p95" >> "$OUTPUT"

echo "Statistiques enregistrées dans $OUTPUT"
