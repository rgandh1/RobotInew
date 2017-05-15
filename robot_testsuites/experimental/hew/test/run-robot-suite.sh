#!/bin/bash

#Create the workspace global variables 
WORKSPACE_PATH=/opt/robot/robotworkspace
ROBOT_WORKSPACE_RESOURCE_FILE=$WORKSPACE_PATH/robotworkspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/TNZ-resource.txt

#Export the CLASSPATH necessary for the robotworkspace 
source $WORKSPACE_PATH/bulk_execution_scripts/robotworkspace-classpath-export.sh

#Create specific PYTHONPATH (only for non-jar-modules)
#ESCAPE=star:STAR
PYTHONPATH_ROBOT=/opt/robot
PYTHONPATH=$PYTHONPATH_ROBOT


#run the robot testsuite
echo "Starting Robot ..."
jybot --outputdir log --pythonpath $PYTHONPATH --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --noncritical noncritical --variable SUT_RESOURCE:$SUT_RESOURCE_FILE SSH-tail-killing-experimental-robot-suite.txt
