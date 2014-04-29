#!/bin/sh

###
# This script installs Ansible for local provisioning on a production server
###

# Setup EPEL repository
rpm -ivh http://ftp.acc.umu.se/mirror/fedora/epel/6/i386/epel-release-6-8.noarch.rpm

# Install ansible and dependencies
yum install -y ansible python-setuptools
