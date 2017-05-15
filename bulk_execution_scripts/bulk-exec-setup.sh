#!/bin/bash
################################################################
# This script defines all initialization steps necessary to
# execute a bulk executing jybot command.
#
# Together with ./bulk-exec-teardown.sh this script is intended 
# to be included (via "source" command) in every bulk execution 
# script to normalize them to the following minimal code:
#
#   source ../bulk-exec-setup.sh
#   jybot <specificArguments>
#   source ../bulk-exec-teardown.sh
#
# Author: walter.heincz
###################################################################

WORKSPACE_PATH=/opt/robot/robotworkspace
BULKEXEC_PATH=$WORKSPACE_PATH/bulk_execution_scripts

#create virtual display (X11 server) in background for Selenium to run the Browser there
#echo "Initializing virtual display (X11 virtual frame buffer) ..."
#Xvfb :99 -ac &
#XvfbPid=$! 
#sleep 2   #give Xvfb time to write his output
#echo "Xvfb running in background under PID=$XvfbPid"
#export DISPLAY=:99

#Export the CLASSPATH necessary for the robotworkspace 
source $BULKEXEC_PATH/robotworkspace-classpath-export.sh

#Export Java heap size settings for the bulk execution 
source $BULKEXEC_PATH/robotworkspace-javamem-export.sh

echo "Starting Robot ..."
