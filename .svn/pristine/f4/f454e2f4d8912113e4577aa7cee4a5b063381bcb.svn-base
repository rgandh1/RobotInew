#!/bin/bash

#include the workspace global variables (PYTHONPATH_SOAPUI and $ESCAPE needed)
WORKSPACE_PATH=/opt/robot/robotworkspace
#source $WORKSPACE_PATH/robotworkspace-bashvars.sh

ESCAPE=star:STAR
PYTHONPATH_SOAPUI=/opt/robot:/opt/soapui-4.5.1/bin/soapui-4.5.1.jar:/opt/soapui-4.5.1/lib/STAR.jar
ROBOT_WORKSPACE_RESOURCE_FILE=$WORKSPACE_PATH/robotworkspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/FALABELLA-CHILE-NewRelease-resource.txt

#run the robot testsuite
jybot --pythonpath $PYTHONPATH_SOAPUI --escape $ESCAPE --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --variable SUT_RESOURCE:$SUT_RESOURCE_FILE MFC_OnNet30s-robot-suite.txt

