#!/usr/bin/env bash

set -eo pipefail

ln -sf /home/pi/juice4halt/conf/juice4halt.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable juice4halt.service --now