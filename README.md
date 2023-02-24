# Extra configuration

## Battery Management

- Install tlp tlp-rdw
- Follow [install instructions](https://linrunner.de/tlp/installation/arch.html) to enable
the services
- Then add
```
START_CHARGE_THRESH_BAT0=50
STOP_CHARGE_THRESH_BAT0=60

DEVICES_TO_DISABLE_ON_STARTUP="bluetooth wifi"

DEVICES_TO_DISABLE_ON_LAN_CONNECT="wifi"
DEVICES_TO_ENABLE_ON_LAN_DISCONNECT="wifi"
```

## GNOME Keyring

- Open seahorse, use your existing keyring or create a new keyring with the name `login` 
- Important is, that you set that keyring as your default **and** set the password of that keyring
to the same one as your login password
- Then, edit your PAM configuration, as described [in the Arch Wiki](https://wiki.archlinux.org/title/GNOME/Keyring#PAM_step)
- Per default, the keyring is not started with SSH, thus you must change the systemd unit
to execute the keyring with SSH enabled
- The simplest way to do so, is the following
  - Create a folder `gnome-keyring-daemon.service.d` in `/usr/lib/systemd/user`
  - Create a file `10-ssh.conf` in that folder, i.e. the path of the file should
    be `/usr/lib/systemd/user/gnome-keyring-daemon.service.d/10-ssh.conf`
  - Place the following in the file:
  ```INI
  [Service]
  ExecStart=
  ExecStart=/usr/bin/gnome-keyring-daemon --foreground --components="ssh,secrets" --control-directory=%t/keyring
  ```
- After a restart it should work, if not, ensure that the gnome-keyring-daemon is not started from somewhere
else, also look at `journalctl -e` for any errors regarding the keyring
- Now, if you are prompted for the SSH password for example, click "Store in keyring" (or similar) so that
the ssh key will be automatically unlocked with the login
