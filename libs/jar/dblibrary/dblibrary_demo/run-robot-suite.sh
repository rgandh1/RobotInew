#!/bin/bash

WORKSPACE_PATH=/opt/robot/robotworkspace
ROBOT_WORKSPACE_RESOURCE_FILE=$WORKSPACE_PATH/robotworkspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/TNZ-resource.txt
PYTHONPATH_DBLIBRARY=$WORKSPACE_PATH/libs/jar/dblibrary/dblibrary-2.0.jar:$WORKSPACE_PATH/libs/jar/dblibrary/postgresql-9.0-801.jdbc4.jar:$WORKSPACE_PATH/libs/jar/dblibrary/unityjdbc.jar:$WORKSPACE_PATH/libs/jar/dblibrary/mongo-java-driver-2.13.0.jar

#run the robot testsuite
echo "Starting Robot ..."
jybot --outputdir log --pythonpath $PYTHONPATH_DBLIBRARY --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --variable SUT_RESOURCE:$SUT_RESOURCE_FILE dblibrary_demo-robot-suite.txt


