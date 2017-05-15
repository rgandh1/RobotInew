##############################################################################
# This script is a kind of "syntax" checker running over all existing
# test suites. It doesn't execute the test suites but checks if all contained
# keywords are resolvable.
# All non-experimental test suites are considered being CRITICAL 
#
# Author: walter.heincz
##############################################################################

source ./bulk-exec-setup.sh
jybot --runmode DryRun --argumentfile default.args --argumentfile TNZ/sut-specific.args --exclude pybot_requiringORexperimental ../robot_testsuites
source ./bulk-exec-teardown.sh
