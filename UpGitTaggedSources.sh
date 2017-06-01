#!/bin/bash

###########################################################################
#
# UpGitTaggedSources
#
# Description:
# Send files (tagged) to GIT E/// Repository
#
# Author: Jesus A. Ruiz (linuxwayven@gmail.com)
#
# Use Mode:
# 1) Change to local repository folder.
# 2) Copy this script in that folder.
# 3) From a bash git console run script file:
#
# UpGitTaggedSources.sh
#
# Version 1.0
#
# CHANGES:
# V1.0 - JRUIZ - 31/05/2017 - In the beginning everything was darkness.
#
###########################################################################

### Global Variables ###
CLONE_DIR=''
PROTOCOL='ssh'
USER='integ01'
IP='10.49.4.208'
GIT_ROOT_DIR='/app01/integ01/'
COUNTRY=''
DEPLOY_TYPE=''
UPPER_DEPLOY_TYPE=''
PASSWORD='tcW0A7Cl'
TAG=''
COMMIT_ID=''
FOLDER_NUM='_00000003'

# Timestamp function
function timestamp () {
  date "+%Y/%m/%d - %H:%M:%S"
}

# Print Welcome Message
function print_welcome_message () {
    clear
    echo '*************************************************************'
    echo ''
    echo 'UpGitTaggedSources 1.0'
    echo ''
    timestamp
    echo ''
    echo ''
}

# Print Bye Message
function print_byebye_message () {
    echo ''
    echo 'THE END.'
    timestamp
    echo '*************************************************************'
}

# Exit routine
function to_exit () {
    print_byebye_message
    exit -1
}

# Print use instrucctions
function print_instructions () {
    echo ''
    echo 'USE: '
    echo '' 
    echo 'UpGitTaggedSources.sh  <Deployment_Type> <Country> <TAG> '
    echo ''
    echo 'Deployment_Type (OSB / FRW) '
    echo 'Country (CHILE / PERU) '
    echo 'TAG (TAG supplied by Release Management) '
    echo ''
}

# Print info message
function print_info_message () {
    echo 'INFO - '$1
}

# Print warning message
function print_warning_message () {
    echo 'WARNING - '$1
}

# Print error message
function print_error_message () {
    echo 'ERROR - '$1
}

# Check if a folder is a git repository
function check_git_repository () {
    if [ ! -d '.git' ] ; then
	print_error_message 'This folder is not a Git Repository'
	to_exit
    fi
}

# Check Deploy Type
function check_deploy_type () {
    echo -n 'Checking deploy type.. '
    if [[ -z "$1"  ]] ; then
	print_error_message 'Incorrect Deploy Type'
	to_exit
    else
	if [ $1 = "OSB" ] || [ $1 = "FRW" ] ; then
	    echo 'OK'
	else
	    print_error_message 'Incorrect Deploy Type'
	    to_exit
	fi
    fi
}

# Check Country Name
function check_country_name () {
    echo -n 'Checking country name.. '
    if [[ -z "$1"  ]] ; then
	print_error_message 'Incorrect Country Name'
	to_exit
    else
	if [ $1 = "CHILE" ] || [ $1 = "PERU" ] ; then
	    echo 'OK'
	else
	    print_error_message 'Incorrect Country Name'
	    to_exit
	fi
    fi
}

# Check TAG Name
function check_tag_name () {
    echo -n 'Checking tag name.. '
    if [[ -z "$1"  ]] ; then
	print_error_message 'Incorrect TAG Name'
	to_exit
    else
	echo 'OK'
    fi
}

# Confirm actions
function confirm_action () {
    while true; do
	read -p "$1 (y/n): " yn
	case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) to_exit;;
            * ) echo "Please answer yes or no.";;
	esac
    done
}

# Git Status
function status_repository () {
    echo ''
    echo '********************* GIT STATUS ****************************'
    git status
    echo '*************************************************************'
    echo ''
}

# Git Clone
function clone_repository() {
    print_info_message "Cloning repository..."
    git clone "$CLONE_PATH"
    print_info_message "Cloning DONE!"
    echo ''
    # Change to cloned folder
    print_info_message "Change to cloned folder: $CLONE_DIR"
    cd $CLONE_DIR
    print_info_message "Directory Change DONE"
    status_repository;
}

# Git Add
function add_repository () {
    echo ''
    print_info_message "Adding files..."
    echo ''
    git add *
    print_info_message "Add DONE!"
    status_repository;
}    

# Git Commit
function commit_repository () {
    echo ''
    print_info_message "Commiting files with TAG => $TAG ..."
    echo ''
    git commit -m "$TAG"
    print_info_message "Commit DONE!"
    status_repository;
}    

# Git Push
function push_repository () {
    echo ''
    print_warning_message "Pushing files to remote repository..."
    if git push
    then
	print_info_message "git push SUCCEEDED"
    else
	print_info_message "git push FAILED"
	to_exit
    fi
    status_repository;
}    

# Git Create TAG Local
function create_tag_repository () {
    echo ''
    print_info_message "Creating TAG ==> $TAG ..."
    # Get first seven characters from the last commit id done.
    TEMP_ID=`git rev-parse HEAD`
    echo $TEMP_ID
    COMMIT_ID=${TEMP_ID:0:7}
    echo $COMMIT_ID
    git tag -a $TAG $COMMIT_ID -m $TAG
    print_info_message "TAG Create DONE!"
    status_repository;
}    

# Git Push TAG Local to remote repository
function push_tag_repository () {
    echo ''
    print_info_message "Pushing TAG ==> $TAG ..."
    git push --tags
    print_info_message "Push TAG DONE!"
    status_repository;
}    

# Create git clone path
function create_clone_path () {
    echo -n 'Creating clone path...'
    UPPER_DEPLOY_TYPE="${DEPLOY_TYPE^^}"
    CLONE_DIR="FULLSTACK_$UPPER_DEPLOY_TYPE$FOLDER_NUM"
    CLONE_PATH="$PROTOCOL://$USER@$IP$GIT_ROOT_DIR$COUNTRY/$DEPLOY_TYPE/FULLSTACK_$UPPER_DEPLOY_TYPE$FOLDER_NUM"
    echo 'Created'y
    print_info_message " Clone Path -> $CLONE_PATH"
    print_info_message " TAG -> $TAG"
}

### MAIN ###
function main {

    # Deployment_Type 
    read -p 'Deployment Type (OSB / FRW): ' r_deploy_type
    check_deploy_type $r_deploy_type;
    DEPLOY_TYPE="${r_deploy_type,,}"
    
    # Country (CHILE / PERU)
    read -p 'Country (CHILE / PERU): ' r_country
    check_country_name $r_country;
    COUNTRY="${r_country,,}"

    # TAG (TAG supplied by Release Management)
    read -p 'TAG (TAG supplied by Release Management): ' r_tag
    check_tag_name $r_tag;
    TAG="$r_tag"

    create_clone_path;

    confirm_action 'Clone Repository?' 'clone_repository';

    echo ''
    echo "************************* ATTENTION *************************"
    echo "*                                                           *"
    echo "*  PLEASE COPY FILES TO CLONED FOLDER BEFORE CONTINUE !!!   *"
    echo "*                                                           *"
    echo "*************************************************************"
    echo ''

    confirm_action 'FILES COPIED ?' 'add_repository';

    confirm_action 'Execute Commit ?' 'commit_repository';

    confirm_action 'Execute Push ? (This operation dont have rollback!!)' 'push_repository';
    # 2017010101_FULLSTACK_FRW_000000001H

    create_tag_repository;

    push_tag_repository;

    print_info_message "All Process finished!!"
}

### SCRIPT BODY ###

print_welcome_message
check_git_repository
main
to_exit

### THE END ###
