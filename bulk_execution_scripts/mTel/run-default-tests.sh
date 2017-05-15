##############################################################################
# This TNZ related bulk execution script is a DEMO that runs 
# all tests from exposed test suites with exception of tests labelled as experimental and End2End
#
# Author: matko.sanseovic
##############################################################################

source ../bulk-exec-setup.sh

PATH=$PATH:/opt/Jython27rc1/bin
export PATH

# clean previous logs and results
rm -f ./log/*

# Starting Robot ...

## note matko.sanseovic on 2015-07-24 Set of includes and excludes below is tested and proven to work - selects XDR and MOC tests
#################################
jybot --argumentfile ../default.args --argumentfile sut-specific.args --exclude experimental --exclude End2EndTest --include MTEL_supported --include MTEL_specific $WORKSPACE_PATH/robot_testsuites

source ../bulk-exec-teardown.sh


