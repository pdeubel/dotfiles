#!/bin/bash

# First archive letsencrypt folder to make it ready for backup
sudo tar -czvf /home/pdeubel/.backup/letsencrypt.tar.gz /etc/letsencrypt

# Backup
sudo rsync -r -t -p -o -g -x -v --progress --delete -l -D -s --exclude-from=/home/pdeubel/.grsync/rsync-homedir-excludes.txt /home/pdeubel/ /run/media/Backup/home/pdeubel
