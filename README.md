# Extra configuration

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
