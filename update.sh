#!/bin/bash
# Enhanced update script with logging

echo "[INFO] Checking source directories..."
if [ ! -d "/home/dwemer/dwemerdistro/bin" ]; then
    echo "[ERROR] Source directory /home/dwemer/dwemerdistro/bin not found!"
    exit 1
fi
if [ ! -d "/home/dwemer/dwemerdistro/etc" ]; then
    echo "[ERROR] Source directory /home/dwemer/dwemerdistro/etc not found!"
    exit 1
fi

echo "[INFO] Found these scripts to update:"
ls -la /home/dwemer/dwemerdistro/bin/

echo "[INFO] Found these config files to update:"
ls -la /home/dwemer/dwemerdistro/etc/

echo "[INFO] Copying scripts to /usr/local/bin..."
cp -v /home/dwemer/dwemerdistro/bin/* /usr/local/bin/
if [ $? -eq 0 ]; then
    echo "[SUCCESS] Scripts successfully copied to /usr/local/bin/"
else
    echo "[ERROR] Error copying scripts to /usr/local/bin/"
    exit 1
fi

echo "[INFO] Copying configuration files to /etc..."
cp -v /home/dwemer/dwemerdistro/etc/* /etc/
if [ $? -eq 0 ]; then
    echo "[SUCCESS] Configuration files successfully copied to /etc/"
else
    echo "[ERROR] Error copying configuration files to /etc/"
    exit 1
fi

echo "[SUCCESS] Update completed successfully!"
