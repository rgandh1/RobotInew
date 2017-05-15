#!/bin/bash

# clean the XDR results
echo "Cleaning old logs ..."
rm -f ./JMS_Test_output.csv
rm -f ./log/*
rm -f ./jmeter.log
rm -f ./root.log
rm -f ./ssh_tail_log-xdr.log

WORKSPACE_PATH=/opt/robot/robotworkspace

ROBOT_WORKSPACE_RESOURCE_FILE=$WORKSPACE_PATH/robotworkspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/VIRGIN_COLUMBIA-resource.txt

#Export the CLASSPATH necessary for the robotworkspace 
source $WORKSPACE_PATH/bulk_execution_scripts/robotworkspace-classpath-export.sh

#Create specific PYTHONPATH (only for non-jar-modules)
#ESCAPE=star:STAR
PYTHONPATH_ROBOT=/opt/robot
PYTHONPATH=$PYTHONPATH_ROBOT

#PATH adaptation needed by Jenkins
PATH=$PATH:/opt/Jython27rc1/bin
export PATH
 
#run the robot testsuite
echo "Starting Robot ..."
jybot --outputdir log --pythonpath $PYTHONPATH --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --variable SUT_RESOURCE:$SUT_RESOURCE_FILE ussd-robot-suite.txt

#remove SoapUI logs
echo "Cleaning up SoapUI logs ..."
rm ./global-groovy.log
rm ./soapui.log
rm ./soapui-errors.log