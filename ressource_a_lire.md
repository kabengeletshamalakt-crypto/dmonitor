Voici une classification des commandes de monitoring Linux par catégories (CPU, Mémoire, Disque, Réseau, Processus), en précisant leurs rôles principaux.

---

### **CPU** (processeur)
- **mpstat** : statistiques détaillées par processeur (utilisateur, système, iowait, etc.).  
- **sar** (option `-u`) : rapports historiques et en temps réel sur l’utilisation CPU.  
- **dstat** (par défaut) : affiche l’utilisation CPU en combinaison avec d’autres ressources.  
- **perf** : outils de profilage CPU avancés (compteurs matériels, échantillonnage).

*Remarque* : `top`/`htop` et `vmstat` donnent aussi des infos CPU, mais ils sont plus généraux.

---

### **Mémoire** (RAM et swap)
- **free** : affiche la mémoire totale, utilisée, libre, les buffers, le cache et l’espace swap.  
- **vmstat** (colonnes `memory`, `swap`) : statistiques sur la mémoire virtuelle, les pages, le swap.  
- **sar** (option `-r`) : rapports sur l’utilisation mémoire et swap.  
- **dstat** (modules `mem`, `swap`) : suivi mémoire en direct.

---

### **Disque** (E/S, espace disque)
- **iostat** : statistiques d’entrées/sorties par disque et partition (IOPS, débit, temps d’attente).  
- **df** : espace disque libre/occupé par système de fichiers.  
- **du** : estimation de l’espace utilisé par les répertoires/fichiers.  
- **sar** (option `-b` ou `-d`) : statistiques d’E/S disque et de charge.  
- **dstat** (module `disk`) : activité disque en temps réel.

---

### **Réseau** (trafic, connexions)
- **netstat** : connexions réseau, tables de routage, statistiques d’interface.  
- **ss** : version moderne et plus rapide de `netstat` pour les sockets.  
- **tcpdump** : capture et analyse du trafic réseau en temps réel.  
- **nstat** : statistiques réseau basées sur les compteurs SNMP du noyau.  
- **sar** (option `-n`) : rapports d’activité réseau (interfaces, sockets, etc.).  
- **dstat** (module `net`) : affiche le trafic réseau entrant/sortant.

---

### **Processus** (activité par processus)
- **top** / **htop** : visualisation interactive des processus (CPU, mémoire, temps).  
- **pidstat** : statistiques individuelles par processus (CPU, mémoire, threads, E/S).  
- **lsof** : liste des fichiers ouverts par processus (y compris sockets réseau).  
- **strace** : trace les appels système et signaux d’un processus (débogage).  
- **perf** (suivi de processus) : peut tracer des événements par processus.

---

### **Multi-catégories / Vue globale**
- **vmstat** : combine CPU, mémoire, disque (E/S), système (interruptions, context switches).  
- **dstat** : outil polyvalent qui peut tout afficher (CPU, mémoire, disque, réseau, etc.).  
- **sar** : outil historique complet, capable de rapporter toutes les métriques ci-dessus.

Cette classification permet d’identifier rapidement l’outil adapté à la ressource que vous souhaitez surveiller.
