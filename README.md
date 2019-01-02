# zfs-check-backup
Bash script for checking zfs snapshots backup

Working well with zfs-bakcup https://github.com/Miso-K/zfs-backup
Also with zfs-auto-snapshot https://github.com/zfsonlinux/zfs-auto-snapshot

This script control if latest backup (zfs snapshots) has today or yesterday date.
If not, mail with information about missing snapshots is sended to support mail.

For info mail sending, postfix or other mail server is needed.
