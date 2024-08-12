# Docker Autocompose
Create .yml files from your docker existing containers

The script runs docker-autocompose then moves the .yml files to your specified folder.

## Requirements

You need to edit line 25 in the script to change saveto= to where you want the .yml files saved to.

Needs [Red5d/docker-autocompose](https://github.com/Red5d/docker-autocompose) installed in docker.

**Notes:** 
1. Red5d/docker-autocompose should **not** be started in docker.

## How to run

**Note:** It needs to be run with sudo -i or sudo -s or the docker.sock command fails.

The script can be run with a container name parameter to process only that container. 
```
sudo -s docker-autocompose.sh plex
```

If run with no parameter, or the "all" parameter, it will process all running containers: 
```
sudo -s docker-autocompose.sh
```

