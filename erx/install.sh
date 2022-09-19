#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "Installing trojan service..."

echo "Installing binary"
chmox a+x ./trojan-go
readlink -f ./trojan-go | xargs -I {} ln -s {} /usr/bin/trojan-go

echo "Installing configuration"
mkdir /etc/trojan-go
readlink -f ./config.yaml | xargs -I {} ln -sf {} /etc/trojan-go/config.yaml

echo "Installing service"
readlink -f ./trojan-go.service | xargs -I {} ln -s {} /etc/systemd/system/trojan-go.service
systemctl daemon-reload
systemctl start trojan-go
systemctl enable trojan-go
