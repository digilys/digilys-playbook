# Digilys playbook

Ansible playbook for provisioning a production environment server for Digilys.
The playbook is developed for Centos 6.

## Setup

The following steps are required to use this playbook:

* Clone the repo.
* Define your configuration in `group_vars/all` by looking at
  `group_vars/all.example`.
* Add SSH public keys for the instance accounts in `public_keys/`. See About SSH
  keys below for more information.

After this, you can run the playbook.

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
    * Initializes PostgreSQL collated with `sv_SE.utf8`
    * Adds a `pg_hba.conf`, see `roles/database/files/pg_hba.conf`
    * Creates databases and database users for the application instances
* `cache`
    * Installes Memcached with a 512 GB cache size
* `application`
    * Installs rbenv globally, along with ruby-build
    * Installs any Ruby version specified in `group_all/all`
    * Sets the global Ruby version to the one specified in `group_all/all`
    * Creates an application user to which Digilys can be deployed, including
      the following things:
        * Authorized SSH keys for access to the user account
        * A `database.yml` pointing to the application's database
        * An `app_config.private.yml` containing a generated secret key
        * A `passenger_port.txt` file for defining Passenger's port
        * A start script `start-digilys-instance.sh` which can start the
          application on boot

## About SSH keys

The Ruby application runs as a dedicated user on the application servers. These
user accounts have no password set, so in order to access them from a remote
machine for doing deployment, the accounts need to have one or more public SSH
keys authorized.

This playbook automatically adds any public key found in `public_keys/` to the
application accounts on the application servers. So, to grant someone deployment
access, just add their SSH key to `public_keys/` and run the playbook.

## Limitations

Currently, this playbook is designed to run on a single server, without any HA
configuration of either the application or the database. The playbook, however,
is prepared for implementing HA and multiple servers in the future.
