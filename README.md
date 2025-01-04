# Docker Autocompose
Create .yml files from your docker existing containers

The script runs docker-autocompose then moves the .yml files to your specified folder.

## Requirements

1. You need to edit `saveto=` in the script to change it to where you want the .yml files saved to.
2. Optionally you can set IncludeHostname to yes to include the NAS' hostname in folder name.

```
# Set the path where you want to .yml files saved to. If blank will save in your home.
saveto="/volume1/Docker"

# Set to yes to include hostname in filename.
# Handy if you have multiple devices that backup to the same location.
IncludeHostname=yes
```

Needs [Red5d/docker-autocompose](https://github.com/Red5d/docker-autocompose) installed in docker.
The script will install Red5d docker-autocopmose if it is not installed.

**Notes:** 
1. You only need the Red5d/docker-autocompose image, so no need to create a container.
2. Red5d/docker-autocompose should not be started in docker (if you created a container).

## How to run

**Note:** It needs to be run with sudo -i or sudo -s or the docker.sock command fails.

The script can be run with a container name parameter to process only that container. 
```
sudo -s docker_autocompose.sh plex
```

If run with no parameter, or the "all" parameter, it will process all running containers: 
```
sudo -s docker_autocompose.sh
```

