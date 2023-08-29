# Docker_Autocompose
Create .yml files from your docker containers

The script runs docker-autocompose then moves the .yml files to your specified folder.

**Note:** It needs to be run with sudo -i or sudo -s or the docker.sock command fails.

The script can be run with a container name parameter to process only that container. 
```
sudo -i docker-autocompose.sh plex
```

If run with no parameter, or the "all" parameter, it will process all running containers: 
```
sudo -s docker-autocompose.sh
```

