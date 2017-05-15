#!/bin/bash
################################################################
# This bash script defines and exports the JAVAMEM necessary
# to specify the max heap size of jbots JVM.
# RF's final reporting phase is extremely memory consuming
# so that the Jython interpreter's default Xmx specification 
# of around 500 MB is much to low for even as small amount of
# testcases executed in one bulk execution run.
#  
# The script is intended to be included (via "source" command)
# in every bulk execution script rather then hardcoding these
# infos. 
#
# ATTENTION: This file is already included in bulk-exec-setup.sh
#            Therefore when bulk-exec-setup.sh is already
#            included in your script you need not additionally
#            include the current one.
#
# Author: walter.heincz
###################################################################

JAVA_MEM=-Xmx2G
export JAVA_MEM

