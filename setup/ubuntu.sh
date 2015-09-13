#!/bin/sh
APPS_LIST="vim zsh screen git openssh-server jenkins python-pip"
PYTHON_MODULES="argparse python-jenkins"

# This is the Debian package repository of Jenkins to automate installation and
# upgrade. To use this repository, first add the key to your system:

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -

# Then add the following entry in your /etc/apt/sources.list:
  
echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/apt/sources.list

# Update your local package index, then finally install Jenkins:

apt-get update # To get the latest package lists
apt-get install -y $APPS_LIST

python -m pip install $PYTHON_MODULES
