#!/bin/bash
BACKUP_MOUNT_DIR=/run/media/Backup

export BORG_PASSCOMMAND='secret-tool lookup borg-backup passphrase'

sudo mkdir -p $BACKUP_MOUNT_DIR

# Ask user for the device, by showing him the options
lsblk
echo
echo
read -p "Select the backup device: /dev/sd" BACKUP_DEV_USER_INPUT

BACKUP_DEVICE_PATH=/dev/sd$BACKUP_DEV_USER_INPUT

sudo mount $BACKUP_DEVICE_PATH $BACKUP_MOUNT_DIR

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

borg create                                                                  \
    --verbose                                                                \
    --progress                                                               \
    --stats                                                                  \
    --patterns-from=/home/pdeubel/.config/borg/patternfile.lst               \
    $BACKUP_MOUNT_DIR/borg-backup::$(hostname)-$(date --iso-8601='seconds')

# Returns exit status of the last command
backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain backups in last 7 days,
# 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '$(hostname)-'         \
    --keep-within   7d              \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \
    $BACKUP_MOUNT_DIR/borg-backup

prune_exit=$?

# Actually free repo disk space by compacting segments

info "Compacting repository"

borg compact $BACKUP_MOUNT_DIR/borg-backup

compact_exit=$?

info "Backup exit $backup_exit Prune exit $prune_exit Compact exit $compact_exit"

# Use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))
global_exit=$(( compact_exit > global_exit ? compact_exit : global_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup, Prune, and Compact finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup, Prune, and/or Compact finished with warnings"
else
    info "Backup, Prune, and/or Compact finished with errors"
fi

sudo umount $BACKUP_DEVICE_PATH

exit ${global_exit}
