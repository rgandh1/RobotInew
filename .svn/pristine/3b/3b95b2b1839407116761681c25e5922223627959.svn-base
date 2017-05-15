#!/bin/bash
################################################################
# This bash script defines and exports the CLASSPATH necessary
# to support all tools (SoapUI, Selenium, JMSLIbrary, ...) 
# possibly required by the testsuites in a bulk execution run.
# Since there may be conflicts between tools when they use
# different versions of the same JAR it is absolutely necessary
# to define a well tested CLASSPATH that supports all tools 
# at the SAME TIME.
# 
# The script is intended to be included (via "source" command)
# in every bulk execution script rather then hardcoding these
# infos. This ensures that when JARs of future tools have
# to be added, none of the existing scripts have to be touched.
#
# ATTENTION: This file is already included in bulk-exec-setup.sh
#            Therefore when bulk-exec-setup.sh is allready
#            included in your script you need not additionally
#            include the current one.
#
# Author: walter.heincz
###################################################################


WORKSPACE_PATH=/opt/robot/robotworkspace

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

#Note: CLASSPATH_SOAPUI must be placed before CLASSPATH_JMSLIBRARY otherwise logging conflicts do occure
CLASSPATH=$CLASSPATH_SELENIUM:$CLASSPATH_SOAPUI:$CLASSPATH_JMSLIBRARY:$CLASSNPATH_DBLIBRARY

export CLASSPATH

