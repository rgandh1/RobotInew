#!/bin/bash


#Create the workspace global variables 
WORKSPACE_PATH=/opt/robot/robotworkspace
ROBOT_WORKSPACE_RESOURCE_FILE=$WORKSPACE_PATH/robotworkspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/TNZ-resource.txt

#Create specific PYTHONPATH (only for non-jar-modules)
#ESCAPE=star:STAR
PYTHONPATH_ROBOT=/opt/robot
PYTHONPATH=$PYTHONPATH_ROBOT

#Create specific CLASSPATH (for JARs)
CLASSPATH_SELENIUM=$WORKSPACE_PATH/libs/jar/selenium-webdriver/selenium-java-2.41.0.jar
for i in $WORKSPACE_PATH/libs/jar/selenium-webdriver/libs/*.jar; do
    CLASSPATH_SELENIUM=$CLASSPATH_SELENIUM:$i
done
CLASSPATH_SOAPUI=/opt/soapui/bin/soapui-5.1.3.jar
for i in /opt/soapui/lib/*.jar; do
    CLASSPATH_SOAPUI=$CLASSPATH_SOAPUI:$i
done
CLASSPATH_JMSLIBRARY=/opt/robot/trilead-ssh2-1.0.0-build217.jar:/opt/robot/robotworkspace/libs/jar/activemq-all-5.9.1.jar
CLASSNPATH_DBLIBRARY=$WORKSPACE_PATH/libs/jar/dblibrary/dblibrary-2.0.jar:$WORKSPACE_PATH/libs/jar/dblibrary/postgresql-9.0-801.jdbc4.jar:$WORKSPACE_PATH/libs/jar/robotframework-jmslibrary-1.0.0-beta.4.jar

CLASSPATH=$CLASSPATH_SELENIUM:$CLASSPATH_SOAPUI:$CLASSPATH_JMSLIBRARY:$CLASSNPATH_DBLIBRARY
export CLASSPATH


# clean the XDR results
echo "Cleaning old logs ..."
rm -f ./log/*
rm -f ./ssh_tail_log-xdr.log


#run the robot testsuite
echo "Starting Robot ..."
jybot --outputdir log --timestampoutputs --pythonpath $PYTHONPATH --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --variable SUT_RESOURCE:$SUT_RESOURCE_FILE XDR_Test-robot-suite.txt

