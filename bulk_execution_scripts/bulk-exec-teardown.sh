#!/bin/bash
################################################################
# This script defines all finalization steps necessary to
# clean up a bulk execution.
#
# Together with ./bulk-exec-setup.sh this script is intended 
# to be included (via "source" command) in every bulk execution 
# script to normalize them to the following minimal code:
#
#   source ../bulk-exec-setup.sh
#   jybot <specificArguments>
#   source ../bulk-exec-teardown.sh
#
# Author: walter.heincz
###################################################################

#kill the X11 server
#echo "Killing virtual display PID $XvfbPid ..."
#kill -9 $XvfbPid

