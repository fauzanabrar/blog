#!/bin/bash

# Konfigurasi
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="./backup/$TIMESTAMP"
MYSQL_CONTAINER="ghost-mysql"
MYSQL_USER="ghost"
MYSQL_PASS="ghostpass"
MYSQL_DB="ghostdb"

# Buat folder backup
mkdir -p "$BACKUP_DIR"

echo "📦 Backup konten Ghost..."
tar -czvf "$BACKUP_DIR/content.tar.gz" content/

echo "🧠 Backup database MySQL..."
docker exec "$MYSQL_CONTAINER" mysqldump -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" > "$BACKUP_DIR/ghostdb.sql"

echo "✅ Backup selesai disimpan di: $BACKUP_DIR"