This following 2 files of this folder make up the robot testsuite:
====================================================================

1) TNZ-WS-PerformanceTests-robot-suite.txt

   is the robotframework testsuite definition that defines 2 testcases refering to the soapUI 
   project ...robotworkspace/external_tests/experimental/hew/SU_MDL_TNZ/Projects/Soap/tnz_ws_mix_loadtest/TNZ_WS-PerformanceTests-soapui-project.xml
   - the 1st one executes the soapUI TC in a single run and
   - the 2nd one executes the soapUI load test


2) run-robot-suite.sh

   is a bash script to execute the robot testsuite (3) from command line.
   But of course the testsuite may also be loaded into RIDE and executed within its GUI.


All other files (except of this readme.txt) are produced by the last run of the robot testsuite and may be deleted.



For more details to the SoapUI project have a look at its readme.txt!





