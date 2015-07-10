#!/bin/sh
APPS_LIST="vim zsh screen"

apt-get update # To get the latest package lists
apt-get install -y $APPS_LIST

