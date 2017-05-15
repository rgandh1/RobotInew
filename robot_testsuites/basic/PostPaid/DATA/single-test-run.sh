#!/bin/bash

WORKSPACE_PATH=/opt/robot/robotworkspace

ROBOT_WORKSPACE_RESOURCE_FILE=$WORKSPACE_PATH/robotworkspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/mTel-resource.txt 

#Export the CLASSPATH necessary for the robotworkspace 
source $WORKSPACE_PATH/bulk_execution_scripts/robotworkspace-classpath-export.sh

#Create specific PYTHONPATH (only for non-jar-modules)
#ESCAPE=star:STAR
PYTHONPATH_ROBOT=/opt/robot
PYTHONPATH=$PYTHONPATH_ROBOT

PATH=$PATH:/opt/Jython27rc1/bin
export PATH
 
#run the robot testsuite
echo "Starting Robot ..."
jybot --outputdir log --pythonpath $PYTHONPATH --test 'Single NOK BalanceExhausted Data Session'  --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --variable SUT_RESOURCE:$SUT_RESOURCE_FILE data-regression-suite.txt

#remove SoapUI logs
echo "Cleaning up SoapUI logs ..."
rm ./global-groovy.log
rm ./soapui.log
rm ./soapui-errors.log

#remove CG logs
echo "Cleaning up CG files ..."
#rm ./logfile.log
#rm ./callsgen.log
#rm ./callsgen.lck
#rm ./workspaces.ini

