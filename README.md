# thinkfan-sensors-updater
Auto-update script for rescan and add senors

A bug was found that sometimes the name of the directory with sensors changes during reboot. This script can be used as a solution.

Add thinkfan.sh to autostart, ex. via crontab @reboot option
```
@reboot /full/path/to/thinkfan.sh
```
