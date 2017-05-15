##############################################################################
# This TNZ related bulk execution script is a DEMO that runs 
# XDR related tests from exposed test suites
#
# Author: matko.sanseovic
##############################################################################

source ../bulk-exec-setup.sh

PATH=$PATH:/opt/Jython27rc1/bin
export PATH

# Starting Robot ...

#################################
jybot --argumentfile ../default.args --argumentfile sut-specific.args --include VIRGIN_COLUMBIA_supportedANDXDR_only --exclude experimental $WORKSPACE_PATH/robot_testsuites
#################################

source ../bulk-exec-teardown.sh


