#!/bin/bash
#############################################################################
# This script triggers bulk execution of the robot workspace's test suites
# that are intended to be run on a daily basis (via cron job).
# Periodic cron job configuration is done by running the following command
# crontab -e
# Typical job configuration (and we want to run the job at 01:00 in the night) looks like:
# 00 01 * * * /opt/robot/robotworkspace/bulk_execution_scripts/nightly-cronjob.sh
#
# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * command to be executed
#
#
# Author: walter.heincz 
##############################################################################

BULKEXEC_ROOT=/opt/robot/robotworkspace/bulk_execution_scripts

#-------------------------- Subroutines --------------------------------------

exec_script() {
  BULKEXEC_SCRIPT_FOLDERNAME=$1                # capture 1st parameter
  BULKEXEC_SCRIPT_NAME=$2                      # ....... 2nd parameter
  
  TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)                                                    # create timestamp for folder name of current script's log-store
  CRONJOB_LOGS=${BULKEXEC_ROOT}/cronjob_logs/${TIMESTAMP}_${BULKEXEC_SCRIPT_FOLDERNAME} # define logs-store path

  cd ${BULKEXEC_ROOT}/${BULKEXEC_SCRIPT_FOLDERNAME}   # change working directory
  rm -f ./log/*                                      # cleanup previous logs
  
  ./${BULKEXEC_SCRIPT_NAME}                           # execute script
  
  mkdir -p ${CRONJOB_LOGS}                            # create new logs-store and ...
#  copying test results isn't needed since we have them on Jenkins anyway
#  ssh root@10.105.80.139 rm -f /var/www/html/RobotTestResults/log_${BULKEXEC_SCRIPT_FOLDERNAME}_*.html       # clean the remote 'web results repository'
#  scp ./log/log-*.html root@10.105.80.139:/var/www/html/RobotTestResults/log_${BULKEXEC_SCRIPT_FOLDERNAME}_${TIMESTAMP}.html    # copy new results to Web
  mv ./log/* ${CRONJOB_LOGS}/                        # ... backup produced logs
} # exec_script()


#-------------------------- Main --------------------------------------
#For each testbed add a line here with the following syntax: 
#  exec_script <testbed's bulk execution folder name> <testbed's bulk execution script name>  

exec_script  TNZ run-default-tests.sh
#TB14 switched off - resources needed for Postpaid
#exec_script  Smartspace  run-default-tests.sh
exec_script  mTel  run-default-tests.sh
exec_script  VMCO  run-default-tests.sh
exec_script  MVNA_MEX  run-default-tests.sh

