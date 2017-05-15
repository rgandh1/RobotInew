##############################################################################
# This TNZ related bulk execution script is a DEMO that runs 
# all tests from exposed test suites with exception of tests labelled as experimental and End2End
#
# Author: matko.sanseovic
##############################################################################

source ../bulk-exec-setup.sh

JAVA_HOME=/usr/lib/jvm/jdk1.7.0_79
export JAVA_HOME

PATH=$PATH:/opt/Jython27rc1/bin
export PATH

# Starting Robot ...

#################################
jybot --argumentfile ../default.args --argumentfile sut-specific.args --exclude experimental --exclude End2EndTest --include TNZ_supported --include TNZ_specific $WORKSPACE_PATH/robot_testsuites

source ../bulk-exec-teardown.sh


