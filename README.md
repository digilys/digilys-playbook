# Digilys playbook

Ansible playbook for provisioning a production environment server for Digilys.
The playbook is developed for Centos 6.

## Running the playbook

There are two ways of running the playbook:

* From a local machine, to a remote server:
    1. Make sure you have the hosts in the `production` inventory resolvable,
       for example via `~/.ssh/config`
    2. Install Ansible locally
    3. Run `ansible-playbook -i production site.yml`
* Locally on the server:
    1. Run `sh bootstrap.sh` to install Ansible
    2. Run `ansible-playbook -i production site.yml --connection=local`

## Limitations

Currently, this playbook is designed to run on a single server, without any HA
configuration of either the application or the database. The playbook, however,
is prepared for implementing HA and multiple servers in the future.
