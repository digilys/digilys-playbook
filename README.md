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

## Roles and their functionality

This playbook defines the following roles:

* `common` - common functionality for all hosts
    * Adds extra Yum repositories
    * Installs Ansible dependencies
* `database`
    * Installs PostgreSQL 9.2
    * Initializes a database collated with `sv_SE.utf8`
    * Adds a `pg_hba.conf`, see `roles/database/files/pg_hba.conf`

## Limitations

Currently, this playbook is designed to run on a single server, without any HA
configuration of either the application or the database. The playbook, however,
is prepared for implementing HA and multiple servers in the future.
