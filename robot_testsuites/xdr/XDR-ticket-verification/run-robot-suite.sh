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
#SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/smartspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/TNZ-resource.txt
PYTHONPATH_DBLIBRARY=$WORKSPACE_PATH/libs/jar/dblibrary/dblibrary-2.0.jar:$WORKSPACE_PATH/libs/jar/dblibrary/postgresql-9.0-801.jdbc4.jar:$WORKSPACE_PATH/libs/jar/robotframework-jmslibrary-1.0.0-beta.4.jar

PATH=$PATH:/opt/Jython27rc1/bin
export PATH

#run the robot testsuite
echo "Starting Robot ..."
jybot --outputdir log --pythonpath $PYTHONPATH_DBLIBRARY --noncritical noncritical --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --variable SUT_RESOURCE:$SUT_RESOURCE_FILE XDR_Test-robot-suite.txt

# cp ./log/*.html /var/www/html/qa_reports/   # not needed any more since Jenkins is collecting test results