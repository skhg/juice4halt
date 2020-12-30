# juice4halt

[juice4halt](https://juice4halt.com/) is a Raspberry Pi [HAT](https://www.raspberrypi.org/blog/introducing-raspberry-pi-hats/) that acts as a [UPS](https://en.wikipedia.org/wiki/Uninterruptible_power_supply). It uses 2 [supercapacitors](https://en.wikipedia.org/wiki/Supercapacitor) to power the Raspberry Pi for a few seconds, enough time for it to safely shut down in the event of a power failure. 

To use this device some scripts are needed to enable communication over [GPIO](https://www.raspberrypi.org/documentation/usage/gpio/), between the Raspberry Pi and the juice4halt. The official site provides some [here](https://juice4halt.com/getting-started) but in this repo i'm instead using `systemd`.

Note: This is only tested on the stock Raspberry Pi OS.

## What this does

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
