# Backing up Docker container volumes

This script creates a *.tar archive for each volume mounted to a specific Docker container.

In order to quickly back up all volumes of your container:

* Install `jq` on your system
* Run `./backup-volumes-container.sh <container-name> <target-dir>`

As a result, a directory will be created in the specified target directory with the name `backup-<container name>-<current date>`.
In that newly created directory there will be one tar archive for each volume mounted to the specified container. The name of the archive will be `<volume-name>.tar`

### Kommet platform
This code is derived from work done on the Kommet platform. Visit https://kommet.io for details.
