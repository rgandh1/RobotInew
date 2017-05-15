##############################################################################
# This TNZ related bulk execution script is a DEMO that runs 
# all tests from exposed test suites with exception of tests labelled as experimental and End2End
#
# Author: matko.sanseovic
##############################################################################

source ../bulk-exec-setup.sh

PATH=$PATH:/opt/Jython27rc1/bin
export PATH

# Starting Robot ...

#######
jybot --argumentfile ../default.args --argumentfile sut-specific.args --exclude experimental --exclude End2EndTest --include VIRGIN_COLUMBIA_supported --include VIRGIN_COLUMBIA_specific $WORKSPACE_PATH/robot_testsuites

source ../bulk-exec-teardown.sh


