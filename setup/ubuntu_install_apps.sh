#!/bin/sh
APPS_LIST="vim zsh"

apt-get update # To get the latest package lists
apt-get install -y $APPS_LIST

