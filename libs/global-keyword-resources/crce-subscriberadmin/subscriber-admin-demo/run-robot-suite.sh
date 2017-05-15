#!/bin/bash



#include the workspace global variables (PYTHONPATH_SOAPUI and $ESCAPE needed)
WORKSPACE_PATH=/opt/robot/robotworkspace
ESCAPE=star:STAR
PYTHONPATH_SOAPUI=/opt/robot:/opt/soapui-4.5.1/bin/soapui-4.5.1.jar:/opt/soapui-4.5.1/lib/xulrunner-linux64-3.0.jar:/opt/soapui-4.5.1/lib/STAR.jar

ROBOT_WORKSPACE_RESOURCE_FILE=$WORKSPACE_PATH/robotworkspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/TNZ-resource.txt

#run the robot testsuite
jybot --outputdir log --pythonpath $PYTHONPATH_SOAPUI --escape $ESCAPE --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --variable SUT_RESOURCE:$SUT_RESOURCE_FILE subscriber-admin_demo-robot-suite.txt
rm ./global-groovy.log
rm ./soapui.log
rm ./soapui-errors.log