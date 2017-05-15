#!/bin/bash



WORKSPACE_PATH=/opt/robot/robotworkspace

ESCAPE=star:STAR
PYTHONPATH_ROBOT=/opt/robot
PYTHONPATH_SELENIUM=$WORKSPACE_PATH/libs/jar/selenium-webdriver/selenium-java-2.41.0.jar:$WORKSPACE_PATH/libs/jar/selenium-webdriver/libs/STAR.jar
PYTHONPATH_SOAPUI=/opt/soapui-4.5.1/bin/soapui-4.5.1.jar:/opt/soapui-4.5.1/lib/xulrunner-linux64-3.0.jar:/opt/soapui-4.5.1/lib/STAR.jar

ROBOT_WORKSPACE_RESOURCE_FILE=$WORKSPACE_PATH/robotworkspace-resource.txt
SUT_RESOURCE_FILE=$WORKSPACE_PATH/suts/TNZ-resource.txt

#create virtual display (X11 server) in background for Selenium to run the Browser there
echo "Initializing virtual display (X11 virtual frame buffer) ..."
Xvfb :99 -ac &
XvfbPid=$! 
sleep 2   #give Xvfb time to write his output
echo "Xvfb running in background under PID=$XvfbPid"
export DISPLAY=:99

#run the robot testsuite
echo "Starting Robot ..."
jybot --outputdir log --pythonpath $PYTHONPATH_ROBOT:$PYTHONPATH_SELENIUM:$PYTHONPATH_SOAPUI --escape $ESCAPE --variable ROBOT_WORKSPACE_RESOURCE:$ROBOT_WORKSPACE_RESOURCE_FILE --variable SUT_RESOURCE:$SUT_RESOURCE_FILE IN_PP_MOC_008-PrepaidMOC-Abandon-robot-suite.txt

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

#kill the X11 server
echo "Killing virtual display PID $XvfbPid ..."
kill -9 $XvfbPid

