# Clone Docker container with its volumes
This script clones a Docker container and all its volumes. It then creates a new container with a given name, and reattaches the new volumes to the new container at the same destinations as the old volumes.

## Usage
Let's assume you have a container called `myapp` with a volume called `myapp-data` mounted at destination `/var/data`; the container exposes port 8080.
To clone the container to a new one called `mycopy`, run:
```
./clone-container.sh myapp <new-container-name> <port-number> <new-image>
```
For example:
```
./clone-container.sh myapp mycopy 8081 kommet/kommet
```

## Important notice regarding naming new volumes
The script assumes that each volume contains the name of the old container. E.g. if the copied container is called `myapp`, the volume names should contain the string `myapp` in their names. Thanks to this the cloning script will know how to call the new volumes: it will simply replace the old container name for the new one.

If the volume name does not contain the container name, the volume will not be cloned. Instead, the script will reattach the old volume to the new container.

## Kommet
This script has been developed for the needs of the Kommet web application platform. To learn more about this open source tool, vitis: https://kommet.io
