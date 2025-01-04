#!/usr/bin/env sh
#--------------------------------------------------------------------------------------
# A script to create docker-compose.yml files from running docker containers.
#
# Script can be run with a container name parameter to only process that container:
# sudo -s docker-autocompose.sh plex
#
# Or with no parameter, or the "all" parameter, to process all running containers:
# sudo -s docker-autocompose.sh all
#
# https://github.com/007revad/Docker_Autocompose
# Adapted from: https://www.synoforum.com/threads/docker-autocompose.4644/#post-20341
#--------------------------------------------------------------------------------------
# REQUIRED:
#
# Needs Red5d/docker-autocompose installed in docker.
# Red5d/docker-autocompose should not be started in docker.
#--------------------------------------------------------------------------------------

# Set the path where you want to .yml files saved to. If blank will save in your home.
saveto="/volume1/Docker"


# Set to yes to include hostname in filename.
# Handy if you have multiple devices that backup to the same location.
IncludeHostname=yes


#--------------------------------------------------------------------------------------

autocompose="red5d/docker-autocompose"

# Check script is running as root (or docker.sock won't run)
if [ $( whoami ) != "root" ]; then
    echo "Script needs to run as root. Aborting."
    exit
fi

# Check our saveto path exists (it saveto is set)
if [ ! -d "${saveto}" ]; then
    echo "saveto path not found. Files will be saved in your home."
    saveto=
fi 

# Get hostname if IncludeHostname is yes
if [ "${IncludeHostname}" == "yes" ]; then
    host="$(hostname)_"
fi


# Create subfolder with date
if [ -d "${saveto}" ]; then
    Now=$( date '+%Y%m%d')
    if mkdir -p "${saveto}/${Now}_${host}docker-autocompose"; then
        path="${saveto}/${Now}_${host}docker-autocompose/"
    fi
fi

# Do the magic
case "${1}" in
    all|"")
        # Create a docker-compose.yml file for each running container
        # Clear existing arguments
        while [ "${1}" ]; do
            shift
        done
        # Create array of running container names
        set -- $(docker ps --format '{{.Names}}')
        while [ "${1}" ]; do
            container_name="${1}"
            docker run --rm -v /var/run/docker.sock:/var/run/docker.sock "${autocompose}" $(docker ps -q --filter name="${container_name}") > "${path}${container_name}"-compose.yml
            echo "${container_name}"
            shift
        done
        ;;
    *)
        # Only process specified container
        container_name="${1}"
        docker run --rm -v /var/run/docker.sock:/var/run/docker.sock "${autocompose}" $(docker ps -q --filter name="${container_name}") > "${path}${container_name}"-compose.yml
        echo "${container_name}"
        ;;
esac

echo "All done"
exit
