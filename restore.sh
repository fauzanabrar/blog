#!/bin/bash

# Konfigurasi
BACKUP_DIR="./backup/2025-10-11_22-58-00"  # Ganti dengan folder backup kamu
MYSQL_CONTAINER="ghost-mysql"
MYSQL_USER="ghost"
MYSQL_PASS="ghostpass"
MYSQL_DB="ghostdb"

# Restore konten Ghost
echo "📂 Restore folder content..."
rm -rf content
mkdir -p content
tar -xzvf "$BACKUP_DIR/content.tar.gz" -C .

# Restore database MySQL
echo "🧠 Restore database MySQL..."
docker cp "$BACKUP_DIR/ghostdb.sql" "$MYSQL_CONTAINER":/ghostdb.sql
docker exec -i "$MYSQL_CONTAINER" bash -c "mysql -u $MYSQL_USER -p$MYSQL_PASS $MYSQL_DB < /ghostdb.sql"

echo "✅ Restore selesai. Jalankan ulang container jika perlu."