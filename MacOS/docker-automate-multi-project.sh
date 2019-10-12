#!/bin/bash

# Created by Pitscher
# https://github.com/pitscher

### Insert your values here

# The URL of your container registry (without protocol like "http://" or "https://")
REGISTRY_URL="some.registry.com"
# The path of your project where the Dockerfile is located (cd into the folder end run the command "pwd")
PROJECT1_PATH="/path/to/project1"
# The name you want to give the Docker image you build and push
PROJECT1_IMAGE_NAME="SomeImageName"
PROJECT2_PATH="/path/to/project2"
PROJECT2_IMAGE_NAME="SomeOtherImageName"

##############################################################
##         FROZEN ZONE - DONT CHANGE THE CODE BELOW         ##
##############################################################

###############
## Functions ##
###############

function fnc_DockerProject1 () {
    clear
    # Display sticky header
    echo "D o c k e r - A u t o m a t e"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo "Your selection: PROJECT1"
    # Check if we can perform docker build (Dockerfile is required)
    # The "%/" removes a tailing "/" if the user would provide one 
    PROJECT1_DOCKERFILE_PATH=${PROJECT1_PATH%/}/Dockerfile
    if [ ! -f "$PROJECT1_DOCKERFILE_PATH" ]; then
        clear
        echo "[ERR]  Not found required Dockerfile"
        echo "There is no Dockerfile at >>> $PROJECT1_PATH <<<"
        echo "Aborting..."
        exit
    else
        echo "[OK]  Found required Dockerfile"
        # Asking the user to enter a tag/version
        echo "Enter a tag (like a version number, e.g. 1.0)"
        read -p "--> " PROJECT1_TAG
        echo "Ok. Set tag/version to >>> $PROJECT1_TAG <<<"
        echo "STEP 1 --> Docker build"
        # Performing Docker commands
        docker build -t $PROJECT1_IMAGE_NAME:$PROJECT1_TAG $PROJECT1_PATH
        echo "STEP 1 --> Done."
        clear
        echo "STEP 2 --> Docker push"
        docker push $PROJECT1_IMAGE_NAME:$PROJECT1_TAG
        echo "STEP 2 --> Done."
        echo "All done. Ending the script..."
        clear
        echo "Bye."
        sleep 1
        clear
        exit
    fi
}

function fnc_DockerProject2 () {
    clear
    # Display sticky header
    echo "D o c k e r - A u t o m a t e"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo "Your selection: PROJECT2"
    # Check if we can perform docker build (Dockerfile is required)
    # The "%/" removes a tailing "/" if the user would provide one 
    PROJECT2_DOCKERFILE_PATH=${PROJECT2_PATH%/}/Dockerfile
    if [ ! -f "$PROJECT2_DOCKERFILE_PATH" ]; then
        clear
        echo "[ERR]  Not found required Dockerfile"
        echo "There is no Dockerfile at >>> $PROJECT2_PATH <<<"
        echo "Aborting..."
        exit
    else
        echo "[OK]  Found required Dockerfile"
        # Asking the user to enter a tag/version
        echo "Enter a tag (like a version number, e.g. 1.0)"
        read -p "--> " PROJECT2_TAG
        echo "Ok. Set tag/version to >>> $PROJECT2_TAG <<<"
        echo "STEP 1 --> Docker build"
        # Performing Docker commands
        docker build -t $PROJECT2_IMAGE_NAME:$PROJECT2_TAG $PROJECT2_PATH
        echo "STEP 1 --> Done."
        clear
        echo "STEP 2 --> Docker push"
        docker push $PROJECT2_IMAGE_NAME:$PROJECT2_TAG
        echo "STEP 2 --> Done."
        echo "All done. Ending the script..."
        clear
        echo "Bye."
        sleep 1
        clear
        exit
    fi
}

function fnc_DockerProject1Project2 () {
    clear
    # Display sticky header
    echo "D o c k e r - A u t o m a t e"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo "Your selection: PROJECT1 + PROJECT2"
    # Check if we can perform docker build (Dockerfile is required)
    # The "%/" removes a tailing "/" if the user would provide one 
    PROJECT1_DOCKERFILE_PATH=${PROJECT1_PATH%/}/Dockerfile
    PROJECT2_DOCKERFILE_PATH=${PROJECT2_PATH%/}/Dockerfile
    if [ ! -f "$PROJECT1_DOCKERFILE_PATH" ] && [ ! -f "$PROJECT2_DOCKERFILE_PATH" ]; then
        clear
        echo "[ERR]  Not found required Dockerfiles"
        echo "There is no Dockerfile at >>> $PROJECT1_PATH <<< or >>> $PROJECT2_PATH <<<"
        echo "Aborting..."
        exit
    else
        echo "[OK]  Found required Dockerfiles"
        # Asking the user to enter a tag/version of PROJECT1
        echo "For PROJECT1 enter a tag (like a version number, e.g. 1.0)"
        read -p "--> " PROJECT1_TAG
        echo "Ok. Set tag/version of PROJECT1 to >>> $PROJECT1_TAG <<<"
        # Asking the user to enter a tag/version of PROJECT2
        echo "For PROJECT2 enter a tag (like a version number, e.g. 1.0)"
        read -p "--> " PROJECT2_TAG
        echo "Ok. Set tag/version of PROJECT2 to >>> $PROJECT2_TAG <<<"
        # Performing Docker commands
        echo "STEP 1 --> Docker build"
        docker build -t $PROJECT1_IMAGE_NAME:$PROJECT1_TAG $PROJECT1_PATH
        clear
        docker build -t $PROJECT2_IMAGE_NAME:$PROJECT2_TAG $PROJECT2_PATH
        echo "STEP 1 --> Done."
        clear
        echo "STEP 2 --> Docker push"
        docker push $PROJECT1_IMAGE_NAME:$PROJECT1_TAG
        clear
        docker push $PROJECT2_IMAGE_NAME:$PROJECT2_TAG
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

# Check if user set a PROJECT1_PATH
if [ ! -z "$PROJECT1_PATH" ]; then
    echo "[OK]   PROJECT1_PATH is set"
else
    echo "[ERR]  PROJECT1_PATH not set (See code of this script)"
    echo "For PROJECT1_PATH set the path of your project where the Dockerfile is located."
    echo "Aborting..."
    exit
fi

# Check if user set a PROJECT1_IMAGE_NAME
if [ ! -z "$PROJECT1_IMAGE_NAME" ]; then
    echo "[OK]   PROJECT1_IMAGE_NAME is set"
else
    echo "[ERR]  PROJECT1_IMAGE_NAME not set (See code of this script)"
    echo "For PROJECT1_IMAGE_NAME set the name of the Docker image you want to build/push."
    echo "Aborting..."
    exit
fi

# Check if user set an PROJECT2_PATH
if [ ! -z "$PROJECT2_PATH" ]; then
    echo "[OK]   PROJECT2_PATH is set"
else
    echo "[ERR]  PROJECT2_PATH not set (See code of this script)"
    echo "For PROJECT2_PATH set the path of your project where the Dockerfile is located."
    echo "Aborting..."
    exit
fi

# Check if user set an PROJECT2_IMAGE_NAME
if [ ! -z "$PROJECT2_IMAGE_NAME" ]; then
    echo "[OK]   PROJECT2_IMAGE_NAME is set"
else
    echo "[ERR]  PROJECT2_IMAGE_NAME not set (See code of this script)"
    echo "For PROJECT2_IMAGE_NAME set the name of the Docker image you want to build/push."
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

echo "Please select what you want to build & push (insert number only)."
options="PROJECT1 PROJECT2 PROJECT1+PROJECT2 Cleaning Cancel"
select option in $options; do
	if [ "PROJECT1" = $option ]; then
		fnc_DockerProject1
	elif [ $option = "PROJECT2" ]; then
		fnc_DockerProject2
   	elif [ $option = "PROJECT1+PROJECT2" ]; then
		fnc_DockerProject1Project2
    elif [ $option = "Cleaning" ]; then
		fnc_DockerClean
    elif [ $option = "Cancel" ]; then
    	echo "Aborting..."
	    exit
	else
        clear
		echo "[ERR]  Unsupported selection (Insert numbers only!)"
        echo "1) PROJECT1 2) PROJECT2 3) PROJECT1 + PROJECT2 4) Cancel"
	fi
done
exit