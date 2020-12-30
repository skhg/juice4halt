# juice4halt

[juice4halt](https://juice4halt.com/) is a Raspberry Pi [HAT](https://www.raspberrypi.org/blog/introducing-raspberry-pi-hats/) that acts as a [UPS](https://en.wikipedia.org/wiki/Uninterruptible_power_supply). It uses 2 [supercapacitors](https://en.wikipedia.org/wiki/Supercapacitor) to power the Raspberry Pi for a few seconds, enough time for it to safely shut down in the event of a power failure. 

To use this device some scripts are needed to enable communication over [GPIO](https://www.raspberrypi.org/documentation/usage/gpio/), between the Raspberry Pi and the juice4halt. The official site provides some [here](https://juice4halt.com/getting-started) but this version uses `systemd` which has some advantages.

Note: This is only tested on the stock Raspberry Pi OS. Other distributions may work but are untested.

## What this does
1. Triggers automatic safe shutdown on power loss
1. Handles manual reboots transparently
1. Lets you monitor the service status

## How it works
When the Raspberry Pi boots, `systemd` activates the `juice4halt.service` which starts the `watchdog.sh` script. It sends a GPIO pulse to the juice4halt informing it that booting is complete. Then it loops forever, listening for a pulse from the juice4halt, indicating that power has been lost. At this point, the watchdog exits its loop, and initiates a system shutdown.

When a manual reboot is needed (after installing new software, or for any other reason), `systemd` runs the `safe-shutdown.sh` script, as part of the regular shutdown process. This ensures that the juice4halt will be in the correct state on the subsequent boot. If this isn't done, the juice4halt will not operate correctly after the reboot.

When a shutdown is triggered by the `watchdog.sh`, this automatic shutdown script is bypassed as it isn't required.

**Important Note:** If the system is commanded to `shutdown` or `poweroff`, (as opposed to `reboot`) power must be physically removed from the juice4halt, and the capacitors must be allowed to fully discharge. The Raspberry Pi will be unable to start a new bootup before the power is **completely** drained.

## How to install
1. Ensure that you have completely removed any existing juice4halt configuration on your Raspberry Pi. (Including commands in your `/etc/rc.local`, etc.)
1. `cd` to your home directory `/home/pi` 
1. Clone this repo to your Raspberry Pi `git clone git@github.com:skhg/juice4halt.git`
1. `cd` to the new `juice4halt` directory
1. Run `sudo ./setup.sh` to install `systemd` configuration.

## How to monitor
Run `systemctl status juice4halt` to see status information and confirm it's running.

Sample output:
```
● juice4halt.service - juice4halt
   Loaded: loaded (/home/pi/juice4halt/conf/juice4halt.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2020-12-30 13:24:17 CET; 3h 25min ago
 Main PID: 353 (watchdog.sh)
    Tasks: 2 (limit: 1939)
   CGroup: /system.slice/juice4halt.service
           ├─ 353 /bin/bash /home/pi/juice4halt/bin/watchdog.sh
           └─6213 sleep 0.2s

Dec 30 13:24:17 television systemd[1]: Started juice4halt.
```
