#!/bin/bash

# Created by Pitscher
# https://github.com/pitscher

### Insert your values here

# The URL of your container registry (without protocol like "http://" or "https://")
REGISTRY_URL="some.registry.com"
# The path of your project where the Dockerfile is located (cd into the folder end run the command "pwd")
PROJECT_PATH="/path/to/PROJECT"
# The name you want to give the Docker image you build and push
PROJECT_IMAGE_NAME="SomeImageName"


##############################################################
##         FROZEN ZONE - DONT CHANGE THE CODE BELOW         ##
##############################################################

###############
## Functions ##
###############

function fnc_DockerPushBuild () {
    clear
    # Display sticky header
    echo "D o c k e r - A u t o m a t e"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo "Your selection: PROJECT"
    # Check if we can perform docker build (Dockerfile is required)
    # The "%/" removes a tailing "/" if the user would provide one 
    PROJECT_DOCKERFILE_PATH=${PROJECT_PATH%/}/Dockerfile
    if [ ! -f "$PROJECT_DOCKERFILE_PATH" ]; then
        clear
        echo "[ERR]  Not found required Dockerfile"
        echo "There is no Dockerfile at >>> $PROJECT_PATH <<<"
        echo "Aborting..."
        exit
    else
        echo "[OK]  Found required Dockerfile"
        # Asking the user to enter a tag/version
        echo "Enter a tag (like a version number, e.g. 1.0)"
        read -p "--> " PROJECT_TAG
        echo "Ok. Set tag/version to >>> $PROJECT_TAG <<<"
        echo "STEP 1 --> Docker build"
        # Performing Docker commands
        docker build -t $PROJECT_IMAGE_NAME:$PROJECT_TAG $PROJECT_PATH
        echo "STEP 1 --> Done."
        clear
        echo "STEP 2 --> Docker push"
        docker push $PROJECT_IMAGE_NAME:$PROJECT_TAG
        echo "STEP 2 --> Done."
        echo "All done. Ending the script..."
        clear
        echo "Bye."
        sleep 1
        clear
        exit
    fi
}

function fnc_DockerClean () {
    clear
    # Display sticky header
    echo "D o c k e r - A u t o m a t e"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo "Your selection: Delete unused Docker images"
    docker images prune -a
    clear
    exit
}

clear
# Display sticky header
echo "D o c k e r - A u t o m a t e"
echo "- - - - - - - - - - - - - - - - -"
echo ""
echo "Checking requirements..."
echo ""

############################
## Checking prerequisites ##
############################

# Check if computer is online
if ping -c 1 8.8.8.8 > /dev/null; then
    echo "[OK]   Computer is online"
else
    echo "[ERR]  Computer is offline"
    echo "Aborting..."
    exit
fi

# Check if docker is installed
if [ -x "$(command -v docker)" ]; then
    echo "[OK]   Docker is installed"
else
    echo "[ERR]  Docker not installed"
    echo "You can install Docker easily via:"
    echo "sudo apt-get install docker-ce or sudo yum install docker-ce or sudo dnf install docker-ce"
    echo "Consult your favourite search engine for further help"
    echo "Aborting..."
    exit
fi

# Check if user set a registry url
if [ ! -z "$REGISTRY_URL" ]; then
    echo "[OK]   Registry url is set"
else
    echo "[ERR]  Registry url not set (See code of this script)"
        echo "For REGISTRY_URL set the url of your Docker registry"
    echo "--> without protocol (http:// or https://)"
    echo "--> without any further path"
    echo "Working example: registry.gitlab.com"
    echo "If you use DockerHub please use index.docker.io"
    echo "Aborting..."
    exit
fi

# Check if user already logged in the configured registry
if ! grep -q "$REGISTRY_URL" ~/.docker/config.json
then
    echo "[WARN] Registry: Login required"
    echo "You can login to you registry easily via: docker login $REGISTRY_URL"
    echo "Aborting..."
else
    echo "[OK]   Registry: Already logged in"
fi

# Check if user set a PROJECT_PATH
if [ ! -z "$PROJECT_PATH" ]; then
    echo "[OK]   PROJECT_PATH is set"
else
    echo "[ERR]  PROJECT_PATH not set (See code of this script)"
    echo "For PROJECT_PATH set the path of your project where the Dockerfile is located."
    echo "Aborting..."
    exit
fi

# Check if user set a PROJECT_IMAGE_NAME
if [ ! -z "$PROJECT_IMAGE_NAME" ]; then
    echo "[OK]   PROJECT_IMAGE_NAME is set"
else
    echo "[ERR]  PROJECT_IMAGE_NAME not set (See code of this script)"
    echo "For PROJECT_IMAGE_NAME set the name of the Docker image you want to build/push."
    echo "Aborting..."
    exit
fi

sleep 1
clear

echo "D o c k e r - A u t o m a t e"
echo "- - - - - - - - - - - - - - - - -"
echo ""

##########################
## Ask user what to do ###
##########################

echo "Please select what you want to do (insert number only)."
options="PROJECT Cleaning Cancel"
select option in $options; do
	if [ "PROJECT" = $option ]; then
		fnc_DockerPushBuild
  elif [ $option = "Cleaning" ]; then
		fnc_DockerClean
  elif [ $option = "Cancel" ]; then
    	echo "Aborting..."
	    exit
	else
        clear
		echo "[ERR]  Unsupported selection (Insert numbers only!)"
        echo "1) PROJECT 2) Cleaning 3) Cancel"
	fi
done
exit