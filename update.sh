#!/bin/bash
# Enhanced update script with logging

echo "🔍 Checking source directories..."
if [ ! -d "/home/dwemer/dwemerdistro/bin" ]; then
    echo "❌ Error: Source directory /home/dwemer/dwemerdistro/bin not found!"
    exit 1
fi
if [ ! -d "/home/dwemer/dwemerdistro/etc" ]; then
    echo "❌ Error: Source directory /home/dwemer/dwemerdistro/etc not found!"
    exit 1
fi

echo "📄 Found these scripts to update:"
ls -la /home/dwemer/dwemerdistro/bin/

echo "📄 Found these config files to update:"
ls -la /home/dwemer/dwemerdistro/etc/

echo "🔄 Copying scripts to /usr/local/bin..."
cp -v /home/dwemer/dwemerdistro/bin/* /usr/local/bin/
if [ $? -eq 0 ]; then
    echo "✅ Scripts successfully copied to /usr/local/bin/"
else
    echo "❌ Error copying scripts to /usr/local/bin/"
    exit 1
fi

echo "🔄 Copying configuration files to /etc..."
cp -v /home/dwemer/dwemerdistro/etc/* /etc/
if [ $? -eq 0 ]; then
    echo "✅ Configuration files successfully copied to /etc/"
else
    echo "❌ Error copying configuration files to /etc/"
    exit 1
fi

echo "🎉 Update completed successfully!"
