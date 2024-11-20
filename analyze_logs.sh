#!/bin/bash

# Файл с логами
LOG_FILE="access.log"

# Подсчет общего количества запросов
total_requests=$(wc -l < "$LOG_FILE")

# Подсчет количества уникальных IP-адресов с использованием awk
unique_ips=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)

# Подсчет количества запросов по методам (GET, POST и т.д.) с использованием awk
method_counts=$(awk '{print $6}' "$LOG_FILE" | sort | uniq -c | awk '{print $2, $1}')

# Поиск самого популярного URL с использованием awk
most_popular_url=$(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2, $1}')

# Создание отчета
cat <<EOL > report.txt
Общее количество запросов: $total_requests
Количество уникальных IP-адресов: $unique_ips
Количество запросов по методам:
$method_counts
Самый популярный URL: $most_popular_url
EOL

# Вывод отчета на экран
cat report.txt
