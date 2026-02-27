#!/bin/bash

# CPU via /proc/stat (comparação entre runs)
STAT_FILE="/tmp/sys_stats_cpu_prev"
read _ user nice system idle iowait irq softirq _ <<< $(grep '^cpu ' /proc/stat)

if [ -f "$STAT_FILE" ]; then
    read p_user p_nice p_system p_idle p_iowait p_irq p_softirq <<< $(cat "$STAT_FILE")
    PREV_TOTAL=$(( p_user + p_nice + p_system + p_idle + p_iowait + p_irq + p_softirq ))
    CURR_TOTAL=$(( user + nice + system + idle + iowait + irq + softirq ))
    DIFF_TOTAL=$(( CURR_TOTAL - PREV_TOTAL ))
    DIFF_IDLE=$(( (idle + iowait) - (p_idle + p_iowait) ))
    [ "$DIFF_TOTAL" -gt 0 ] && CPU=$(( (DIFF_TOTAL - DIFF_IDLE) * 100 / DIFF_TOTAL )) || CPU=0
else
    CPU=0
fi
echo "$user $nice $system $idle $iowait $irq $softirq" > "$STAT_FILE"

# Memory
read MEM_TOTAL MEM_USED MEM_FREE MEM_CACHE <<< $(free -m | awk 'NR==2{print $2, $3, $4, $6}')
MEM_PERCENT=$(( MEM_USED * 100 / MEM_TOTAL ))

ICON=$(printf '\uf4bc')
TOOLTIP="CPU: ${CPU}%\rMemória: ${MEM_USED}MB / ${MEM_TOTAL}MB (${MEM_PERCENT}%)\rLivre: ${MEM_FREE}MB\rCache: ${MEM_CACHE}MB"

echo "{\"text\": \"${ICON}\", \"tooltip\": \"${TOOLTIP}\"}"
