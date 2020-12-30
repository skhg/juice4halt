# juice4halt
systemd scripts for the juice4halt Raspberry Pi module

## Install

```
sudo ln -s /home/pi/juice4halt/conf/juice4halt.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable juice4halt.service --now
```
