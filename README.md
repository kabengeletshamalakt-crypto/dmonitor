# Mon Projet Shell

## Description
Ce projet est un ensemble de scripts shell conçus pour [décrire l'objectif : surveiller les ressources système, automatiser des tâches, analyser des logs, etc.]. Il exploite directement les interfaces du noyau Linux (`/proc`, `/sys`) pour fournir des informations précises et légères, sans dépendances lourdes.

## Fonctionnalités
- Collecte de métriques [CPU, mémoire, disque, réseau] en temps réel.
- Génération de rapports statistiques (moyenne, écart-type, centiles).
- Export des données au format CSV ou JSON.
- [Ajoutez d'autres fonctionnalités clés]

## Prérequis
- Système d'exploitation : Linux (noyau 2.6+)
- Interpréteur : Bash 4.0 ou plus récent
- Paquets recommandés : `bc`, `awk`, `grep`, `sed` (généralement installés par défaut)

## Installation
1. Clonez le dépôt :
   ```bash
   git clone https://github.com/votrecompte/mon-projet-shell.git
   cd mon-projet-shell
   ```
2. Rendez les scripts exécutables :
   ```bash
   chmod +x scripts/*.sh
   ```
3. (Optionnel) Ajoutez le répertoire `scripts/` à votre `PATH` pour une utilisation système.

## Utilisation
### Collecte de données CPU
```bash
./scripts/collecte_cpu.sh [durée_en_secondes] > cpu_data.txt
```
Exemple :
```bash
./scripts/collecte_cpu.sh 60 > cpu_60s.txt
```

### Analyse statistique
```bash
./scripts/analyse_stats.sh fichier_donnees.txt
```
Le script affiche la moyenne, l'écart-type, la médiane, le min, le max et le 95e percentile.

### Aide
Chaque script supporte l'option `-h` ou `--help` pour afficher les instructions détaillées.

## Exemples
```bash
# Surveiller l'utilisation CPU pendant 10 secondes
./scripts/collecte_cpu.sh 10

# Analyser un fichier existant
./scripts/analyse_stats.sh cpu_data.txt

# Générer un rapport JSON
./scripts/to_json.sh cpu_data.txt > rapport.json
```

## Structure du projet
```
mon-projet-shell/
├── README.md
├── LICENSE
├── scripts/
│   ├── collecte_cpu.sh
│   ├── analyse_stats.sh
│   ├── to_json.sh
│   └── utils.sh
├── tests/
│   └── test_collecte.sh
└── docs/
    └── documentation.pdf
```

## Contribution
Les contributions sont les bienvenues ! Merci de suivre ces étapes :
1. Forkez le projet.
2. Créez une branche pour votre fonctionnalité (`git checkout -b feature/amazing-feature`).
3. Commitez vos changements (`git commit -m 'Ajout d'une fonctionnalité incroyable'`).
4. Poussez vers la branche (`git push origin feature/amazing-feature`).
5. Ouvrez une Pull Request.

## Licence
Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

---

**Note** : Ce projet est conçu à des fins éducatives et d'administration système. Adaptez-le selon vos besoins.
