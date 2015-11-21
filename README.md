docker-moodle-dev
=================

Set up Docker containers for developing Moodle on Mac OS X.

The PHP code of Moodle is mounted from the host's subdirectory `./moodle`.

Note that this configuration uses PostgreSQL as database and not MySQL.

All the scripts must be run from the directory containing `Dockerfile` and `docker-compose.yml`.

## Setup

Requires Docker and Docker-machine VM to be installed, and optionally Docker-compose as well.

Create a subdirectory named `moodle`, containing the moodle installation to be used. Possibly clone it from git:
```
git clone -b MOODLE_29_STABLE git://git.moodle.org/moodle.git
```

## Moodle config

The `moodle-config.php` file contains Moodle configuration.

This is based on Moodle 2.6 config file. 
Change it as required, without removing references to environment variables (`getenv(...)`) used to dockerise Moodle.

This file will be copied into the `./moodle` subdirectory, renamed to `config.php` 
(Note that `config.php` is ignored in the standard Moodle git repo, so there is no risk to commit it by mistake).


## Start Docker machine

A Docker machine (VM) must be running on the host:
```
./start-dockermachine.sh
```
Starts a VM named *default_*(if does not exist yet)


## Build and run containers

Two approaches are available:
- Run using Docker-compose
- Run manually, using scripts


### Use Docker-compose

The IP of the Docker-machine VM is hardwired in `docker-compose.yml`.
If the VM uses an IP different from `192.169.99.100`, the file must be changed accordingly.

*TODO Make VM machine parametric*

#### Build and start services
```
docker-compose up -d
```

#### Install Moodle

Edit `install-moodle.sh` to change the site language, name and admin account.

```
./install-moodle.sh
```

Note that stopped services retain their state. 
If restarted using  `docker-compose up` there is no need to reinstall Moodle.

#### Stop containers

```
docker-compose stop
```

### Directly using Docker

This approach uses bash script to build and start containers, and to install Moodle.

The scripts automatically detect the IP used by the Docker-machine VM.

#### Build images
```
./build-images.sh
```

#### Start containers
```
./start-containers.sh
```

#### Install moodle
```
./install-moodle.sh
```
