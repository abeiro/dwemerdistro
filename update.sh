#!/bin/bash
# Enhanced update script with minimal output

echo "[INFO] Checking source directories..."
if [ ! -d "/home/dwemer/dwemerdistro/bin" ]; then
    echo "[ERROR] Source directory /home/dwemer/dwemerdistro/bin not found!"
    exit 1
fi
if [ ! -d "/home/dwemer/dwemerdistro/etc" ]; then
    echo "[ERROR] Source directory /home/dwemer/dwemerdistro/etc not found!"
    exit 1
fi

echo "[INFO] Copying scripts to /usr/local/bin..."
cp /home/dwemer/dwemerdistro/bin/* /usr/local/bin/ 2>/dev/null
if [ $? -eq 0 ]; then
    echo "[SUCCESS] Scripts successfully copied to /usr/local/bin/"
else
    echo "[ERROR] Error copying scripts to /usr/local/bin/"
    exit 1
fi

echo "[INFO] Copying configuration files to /etc..."
cp /home/dwemer/dwemerdistro/etc/* /etc/ 2>/dev/null
if [ $? -eq 0 ]; then
    echo "[SUCCESS] Configuration files successfully copied to /etc/"
else
    echo "[ERROR] Error copying configuration files to /etc/"
    exit 1
fi

echo "[SUCCESS] Update completed successfully!"
echo "Begin CHIM Server Update"
