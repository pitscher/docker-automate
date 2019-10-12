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
    echo -e "\e[1mD o c k e r - A u t o m a t e\e[0m"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo -e "\e[1mYour selection: PROJECT\e[0m"
    # Check if we can perform docker build (Dockerfile is required)
    # The "%/" removes a tailing "/" if the user would provide one 
    PROJECT_DOCKERFILE_PATH=${PROJECT_PATH%/}/Dockerfile
    if [ ! -f "$PROJECT_DOCKERFILE_PATH" ]; then
        clear
        echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m Not found required Dockerfile\e[0m"
        echo -e "\e[2mThere is no Dockerfile at >>> $PROJECT_PATH <<<\e[0m"
        echo -e "\e[2mAborting...\e[0m"
        exit
    else
        echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m Found required Dockerfile\e[0m"
        # Asking the user to enter a tag/version
        echo -e "\e[1mEnter a tag (like a version number, e.g. 1.0)\e[0m"
        read -p "--> " PROJECT_TAG
        echo -e "\e[2mOk. Set tag/version to >>>\e[0m $PROJECT_TAG \e[2m<<<\e[0m"
        echo -e "\e[1mSTEP 1 --> Docker build\e[0m"
        # Performing Docker commands
        docker build -t $PROJECT_IMAGE_NAME:$PROJECT_TAG $PROJECT_PATH
        echo -e "\e[1mSTEP 1 --> Done.\e[0m"
        clear
        echo -e "\e[1mSTEP 2 --> Docker push\e[0m"
        docker push $PROJECT_IMAGE_NAME:$PROJECT_TAG
        echo -e "\e[1mSTEP 2 --> Done.\e[0m"
        echo -e "\e[1mAll done. Ending the script...\e[0m"
        clear
        echo -e "\e[1mBye.\e[0m"
        sleep 1
        clear
        exit
    fi
}

function fnc_DockerClean () {
    clear
    # Display sticky header
    echo -e "\e[1mD o c k e r - A u t o m a t e\e[0m"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo -e "\e[1mYour selection: Delete unused Docker images\e[0m"
    docker images prune -a
    clear
    exit
}

clear
# Display sticky header
echo -e "\e[1mD o c k e r - A u t o m a t e\e[0m"
echo "- - - - - - - - - - - - - - - - -"
echo ""
echo -e "\e[1mChecking requirements...\e[0m"
echo ""

############################
## Checking prerequisites ##
############################

# Check if computer is online
if ping -c 1 8.8.8.8 > /dev/null; then
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  Computer is online\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m Computer is offline\e[0m"
    echo -e "\e[2mAborting...\e[0m"
    exit
fi

# Check if docker is installed
if [ -x "$(command -v docker)" ]; then
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  Docker is installed\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m Docker not installed\e[0m"
    echo -e "You can install Docker easily via:\n\e[7msudo apt-get install docker-ce\e[0m or\n\e[7msudo yum install docker-ce\e[0m or\n\e[7msudo dnf install docker-ce\e[0m"
    echo "Consult your favourite search engine for further help"
    echo -e "\e[2mAborting...\e[0m"
    exit
fi

# Check if user set a registry url
if [ ! -z "$REGISTRY_URL" ]; then
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  Registry url is set\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m Registry url not set \e[2m(See code of this script)\e[0m"
    echo -e "For REGISTRY_URL set the url of your Docker registry\n--> without protocol (http:// or https://)\n--> without any further path\n\nWorking example: registry.gitlab.com\n\nIf you use DockerHub please use index.docker.io\n\n"
    echo -e "\e[2mAborting...\e[0m"
    exit
fi

# Check if user already logged in the configured registry
if ! grep -q "$REGISTRY_URL" ~/.docker/config.json
then
    echo -e "\e[2m[\e[0m\e[1m\e[93mWARN\e[0m\e[1m\e[2m]\e[0m \e[1mRegistry: Login required\e[0m"
    echo -e "You can login to you registry easily via:\n\e[7mdocker login $REGISTRY_URL\e[0m"
    echo -e "\e[2mAborting...\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  Registry: Already logged in\e[0m"
fi

# Check if user set a PROJECT_PATH
if [ ! -z "$PROJECT_PATH" ]; then
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  PROJECT_PATH is set\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m PROJECT_PATH not set \e[2m(See code of this script)\e[0m"
    echo -e "For PROJECT_PATH set the path of your project where the Dockerfile is located."
    echo -e "\e[2mAborting...\e[0m"
    exit
fi

# Check if user set a PROJECT_IMAGE_NAME
if [ ! -z "$PROJECT_IMAGE_NAME" ]; then
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  PROJECT_IMAGE_NAME is set\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m PROJECT_IMAGE_NAME not set \e[2m(See code of this script)\e[0m"
    echo -e "For PROJECT_IMAGE_NAME set the name of the Docker image you want to build/push."
    echo -e "\e[2mAborting...\e[0m"
    exit
fi

sleep 1
clear

echo -e "\e[1mD o c k e r - A u t o m a t e\e[0m"
echo "- - - - - - - - - - - - - - - - -"
echo ""

##########################
## Ask user what to do ###
##########################

echo -e "\e[1mPlease select what you want to do (insert number only).\e[0m"
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
		echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m Unsupported selection \e[2m(Insert numbers only!)\e[0m"
        echo -e "\e[2m1) PROJECT\e[0m\n\e[2m2) Cleaning\e[2\nm3) Cancel\e[0m"
	fi
done
exit