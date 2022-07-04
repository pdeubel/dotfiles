#!/bin/bash
BORG_PASSCOMMAND='secret-tool lookup borg-backup passphrase' borg create --verbose --list --stats --patterns-from=/home/pdeubel/.config/borg/patternfile.lst /run/media/Backup/borg-backup::$(date --iso-8601='seconds')-$(hostname)
