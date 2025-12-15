#!/bin/sh
set -e

# Host-Keys erzeugen, falls noch nicht vorhanden
ssh-keygen -A

# Zielpfad für gemini vorbereiten
mkdir -p /home/gemini/.ssh
chown gemini:gemini /home/gemini/.ssh
chmod 700 /home/gemini/.ssh

# Secret (read-only) in beschreibbare authorized_keys kopieren + Rechte setzen
cp /run/secrets/gemini_authorized_key /home/gemini/.ssh/authorized_keys
chown gemini:gemini /home/gemini/.ssh/authorized_keys
chmod 600 /home/gemini/.ssh/authorized_keys

# sshd im Vordergrund starten (damit der Container läuft)
exec /usr/sbin/sshd -D -e