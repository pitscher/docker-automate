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
    echo -e "\e[1mD o c k e r - A u t o m a t e\e[0m"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo -e "\e[1mYour selection: PROJECT1\e[0m"
    # Check if we can perform docker build (Dockerfile is required)
    # The "%/" removes a tailing "/" if the user would provide one 
    PROJECT1_DOCKERFILE_PATH=${PROJECT1_PATH%/}/Dockerfile
    if [ ! -f "$PROJECT1_DOCKERFILE_PATH" ]; then
        clear
        echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m Not found required Dockerfile\e[0m"
        echo -e "\e[2mThere is no Dockerfile at >>> $PROJECT1_PATH <<<\e[0m"
        echo -e "\e[2mAborting...\e[0m"
        exit
    else
        echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m Found required Dockerfile\e[0m"
        # Asking the user to enter a tag/version
        echo -e "\e[1mEnter a tag (like a version number, e.g. 1.0)\e[0m"
        read -p "--> " PROJECT1_TAG
        echo -e "\e[2mOk. Set tag/version to >>>\e[0m $PROJECT1_TAG \e[2m<<<\e[0m"
        echo -e "\e[1mSTEP 1 --> Docker build\e[0m"
        # Performing Docker commands
        docker build -t $PROJECT1_IMAGE_NAME:$PROJECT1_TAG $PROJECT1_PATH
        echo -e "\e[1mSTEP 1 --> Done.\e[0m"
        clear
        echo -e "\e[1mSTEP 2 --> Docker push\e[0m"
        docker push $PROJECT1_IMAGE_NAME:$PROJECT1_TAG
        echo -e "\e[1mSTEP 2 --> Done.\e[0m"
        echo -e "\e[1mAll done. Ending the script...\e[0m"
        clear
        echo -e "\e[1mBye.\e[0m"
        sleep 1
        clear
        exit
    fi
}

function fnc_DockerProject2 () {
    clear
    # Display sticky header
    echo -e "\e[1mD o c k e r - A u t o m a t e\e[0m"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo -e "\e[1mYour selection: PROJECT2\e[0m"
    # Check if we can perform docker build (Dockerfile is required)
    # The "%/" removes a tailing "/" if the user would provide one 
    PROJECT2_DOCKERFILE_PATH=${PROJECT2_PATH%/}/Dockerfile
    if [ ! -f "$PROJECT2_DOCKERFILE_PATH" ]; then
        clear
        echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m Not found required Dockerfile\e[0m"
        echo -e "\e[2mThere is no Dockerfile at >>> $PROJECT2_PATH <<<\e[0m"
        echo -e "\e[2mAborting...\e[0m"
        exit
    else
        echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m Found required Dockerfile\e[0m"
        # Asking the user to enter a tag/version
        echo -e "\e[1mEnter a tag (like a version number, e.g. 1.0)\e[0m"
        read -p "--> " PROJECT2_TAG
        echo -e "\e[2mOk. Set tag/version to >>>\e[0m $PROJECT2_TAG \e[2m<<<\e[0m"
        echo -e "\e[1mSTEP 1 --> Docker build\e[0m"
        # Performing Docker commands
        docker build -t $PROJECT2_IMAGE_NAME:$PROJECT2_TAG $PROJECT2_PATH
        echo -e "\e[1mSTEP 1 --> Done.\e[0m"
        clear
        echo -e "\e[1mSTEP 2 --> Docker push\e[0m"
        docker push $PROJECT2_IMAGE_NAME:$PROJECT2_TAG
        echo -e "\e[1mSTEP 2 --> Done.\e[0m"
        echo -e "\e[1mAll done. Ending the script...\e[0m"
        clear
        echo -e "\e[1mBye.\e[0m"
        sleep 1
        clear
        exit
    fi
}

function fnc_DockerProject1Project2 () {
    clear
    # Display sticky header
    echo -e "\e[1mD o c k e r - A u t o m a t e\e[0m"
    echo "- - - - - - - - - - - - - - - - -"
    echo ""
    echo -e "\e[1mYour selection: PROJECT1 + PROJECT2\e[0m"
    # Check if we can perform docker build (Dockerfile is required)
    # The "%/" removes a tailing "/" if the user would provide one 
    PROJECT1_DOCKERFILE_PATH=${PROJECT1_PATH%/}/Dockerfile
    PROJECT2_DOCKERFILE_PATH=${PROJECT2_PATH%/}/Dockerfile
    if [ ! -f "$PROJECT1_DOCKERFILE_PATH" ] && [ ! -f "$PROJECT2_DOCKERFILE_PATH" ]; then
        clear
        echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m Not found required Dockerfiles\e[0m"
        echo -e "\e[2mThere is no Dockerfile at >>> $PROJECT1_PATH <<< or >>> $PROJECT2_PATH <<<\e[0m"
        echo -e "\e[2mAborting...\e[0m"
        exit
    else
        echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m Found required Dockerfiles\e[0m"
        # Asking the user to enter a tag/version of PROJECT1
        echo -e "\e[1mFor PROJECT1 enter a tag (like a version number, e.g. 1.0)\e[0m"
        read -p "--> " PROJECT1_TAG
        echo -e "\e[2mOk. Set tag/version of PROJECT1 to >>>\e[0m $PROJECT1_TAG \e[2m<<<\e[0m"
        # Asking the user to enter a tag/version of PROJECT2
        echo -e "\e[1mFor PROJECT2 enter a tag (like a version number, e.g. 1.0)\e[0m"
        read -p "--> " PROJECT2_TAG
        echo -e "\e[2mOk. Set tag/version of PROJECT2 to >>>\e[0m $PROJECT2_TAG \e[2m<<<\e[0m"
        # Performing Docker commands
        echo -e "\e[1mSTEP 1 --> Docker build\e[0m"
        docker build -t $PROJECT1_IMAGE_NAME:$PROJECT1_TAG $PROJECT1_PATH
        clear
        docker build -t $PROJECT2_IMAGE_NAME:$PROJECT2_TAG $PROJECT2_PATH
        echo -e "\e[1mSTEP 1 --> Done.\e[0m"
        clear
        echo -e "\e[1mSTEP 2 --> Docker push\e[0m"
        docker push $PROJECT1_IMAGE_NAME:$PROJECT1_TAG
        clear
        docker push $PROJECT2_IMAGE_NAME:$PROJECT2_TAG
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

# Check if user set a PROJECT1_PATH
if [ ! -z "$PROJECT1_PATH" ]; then
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  PROJECT1_PATH is set\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m PROJECT1_PATH not set \e[2m(See code of this script)\e[0m"
    echo -e "For PROJECT1_PATH set the path of your project where the Dockerfile is located."
    echo -e "\e[2mAborting...\e[0m"
    exit
fi

# Check if user set a PROJECT1_IMAGE_NAME
if [ ! -z "$PROJECT1_IMAGE_NAME" ]; then
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  PROJECT1_IMAGE_NAME is set\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m PROJECT1_IMAGE_NAME not set \e[2m(See code of this script)\e[0m"
    echo -e "For PROJECT1_IMAGE_NAME set the name of the Docker image you want to build/push."
    echo -e "\e[2mAborting...\e[0m"
    exit
fi

# Check if user set an PROJECT2_PATH
if [ ! -z "$PROJECT2_PATH" ]; then
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  PROJECT2_PATH is set\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m PROJECT2_PATH not set \e[2m(See code of this script)\e[0m"
    echo -e "For PROJECT2_PATH set the path of your project where the Dockerfile is located."
    echo -e "\e[2mAborting...\e[0m"
    exit
fi

# Check if user set an PROJECT2_IMAGE_NAME
if [ ! -z "$PROJECT2_IMAGE_NAME" ]; then
    echo -e "\e[2m[\e[0m\e[1m\e[92mOK\e[0m\e[1m\e[2m]\e[0m \e[1m  PROJECT2_IMAGE_NAME is set\e[0m"
else
    echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m PROJECT2_IMAGE_NAME not set \e[2m(See code of this script)\e[0m"
    echo -e "For PROJECT2_IMAGE_NAME set the name of the Docker image you want to build/push."
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

echo -e "\e[1mPlease select what you want to build & push (insert number only).\e[0m"
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
		echo -e "\e[2m[\e[0m\e[1m\e[91mERR\e[0m\e[1m\e[2m]\e[0m \e[1m Unsupported selection \e[2m(Insert numbers only!)\e[0m"
        echo -e "\e[2m1) PROJECT1\e[0m\n\e[2m2) PROJECT2\e[0m\n\e[2m3) PROJECT1 + PROJECT2\e[0m\n\e[2m4) Cancel\e[0m"
	fi
done
exit