# juice4halt

[juice4halt](https://juice4halt.com/) is a Raspberry Pi [HAT](https://www.raspberrypi.org/blog/introducing-raspberry-pi-hats/) that acts as a [UPS](https://en.wikipedia.org/wiki/Uninterruptible_power_supply). It uses 2 [supercapacitors](https://en.wikipedia.org/wiki/Supercapacitor) to power the Raspberry Pi for a few seconds, enough time for it to safely shut down.

To use this device some scripts are needed to enable communication over [GPIO](https://www.raspberrypi.org/documentation/usage/gpio/), between the Raspberry Pi and the juice4halt. The official site provides some [here](https://juice4halt.com/getting-started) but there are some shortcomings I wanted to improve on.


systemd configuration for the juice4halt Raspberry Pi module

## Install

```
sudo ln -s /home/pi/juice4halt/conf/juice4halt.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable juice4halt.service --now
```
