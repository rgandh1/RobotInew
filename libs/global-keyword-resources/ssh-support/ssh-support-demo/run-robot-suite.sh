#!/bin/bash

WORKSPACE_PATH=/opt/robot/robotworkspace
ROBOT_WORKSPACE_RESOURCE_FILE=$WORKSPACE_PATH/robotworkspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/TNZ-resource.txt

#run the robot testsuite
jybot --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --variable SUT_RESOURCE:$SUT_RESOURCE_FILE ssh_demo-robot-suite.txt

