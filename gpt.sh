#!/bin/bash

# ============================
# Simple Linux Monitoring Agent
# Compatible RHEL/CentOS
# ============================

BASE_DIR="/opt/monitoring"
LOG_DIR="$BASE_DIR/logs"
HOSTNAME=$(hostname)
DATE=$(date +"%Y-%m-%d")
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
CSV_FILE="$LOG_DIR/metrics_$DATE.csv"

mkdir -p "$LOG_DIR"

# ===== CPU =====
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
CPU_USAGE=$((100 - CPU_IDLE))

# ===== LOAD =====
LOAD1=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | xargs)

# ===== MEMORY =====
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED/$MEM_TOTAL)*100}")

# ===== DISK ROOT =====
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# ===== NETWORK =====
RX_BYTES=$(cat /proc/net/dev | awk '/eth0/ {print $2}')
TX_BYTES=$(cat /proc/net/dev | awk '/eth0/ {print $10}')

# ===== PROCESS COUNT =====
PROC_COUNT=$(ps aux | wc -l)

# ===== IMPORTANT SERVICES =====
SSH_STATUS=$(systemctl is-active sshd 2>/dev/null)
CRON_STATUS=$(systemctl is-active crond 2>/dev/null)

# ===== Header (only if file doesn't exist) =====
if [ ! -f "$CSV_FILE" ]; then
    echo "timestamp,hostname,cpu_usage_percent,load_1min,mem_used_mb,mem_total_mb,mem_percent,disk_used,disk_total,disk_percent,rx_bytes,tx_bytes,process_count,ssh_status,cron_status" >> "$CSV_FILE"
fi

# ===== Write Data =====
echo "$TIMESTAMP,$HOSTNAME,$CPU_USAGE,$LOAD1,$MEM_USED,$MEM_TOTAL,$MEM_PERCENT,$DISK_USED,$DISK_TOTAL,$DISK_PERCENT,$RX_BYTES,$TX_BYTES,$PROC_COUNT,$SSH_STATUS,$CRON_STATUS" >> "$CSV_FILE"
