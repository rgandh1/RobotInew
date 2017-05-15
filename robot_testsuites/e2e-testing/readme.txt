Change Log:
===========

  Date      Author                   Comments
----------  -----------------------  -----------------------------------------
2014/06/23  walter.heincz            Initial creation 
------------------------------------------------------------------------------

Description:
============
This folder contains end-to-end test automation testcases based on the manual flow description in VMLA_MEX_Initial_Service_Tests_v2.xlsx (SMS and USSD group are excluded).
Due to the lack of a valid MEXICO testbed this robot suite was developed by using the TNZ testbed (TB04) for debugging (verification) - except for the IN_BST_005-MOCtoForbiddenNumber-robot-suite.txt, which was tested in FALABELLA testbed (TB08), since the required feature was not available in TNZ.

Execution Time: around 1hr
Required Jython Heap Settings: Xmx2g    (see JAVA_MEM variable in /opt/jython2.5.3/jyton script)

Rough Layering Overview:
  |-------------------------------------------------------------------------------------------------------------------------------------------
  |                                   jybot (passing robotworkspace-resource.txt & SUT_RESOURCE)                                             |
  |------------------------------------------------------------------------------------------------------------------------------------------|
  |                        Xxx-robot-suite.txt (using configuration-resource.txt & suite-global-keyword-resource.txt)                        |
  |------------------------------------------------------------------------------------------------------------------------------------------|
  |      ars_support-resource.txt         |  cg_support-resource.txt  |  crm_support-resource.txt  |  subscriber-admin-support-resource.txt  |
  |---------------------------------------|---------------------------|----------------------------|-----------------------------------------|
  |  robot_ars_bridge-soapui-project.xml  |     external iSig TCs     |  InewSelenium2Library.py   |  robot_crce_bridge-soapui-project.xml   |
  |---------------------------------------|---------------------------|----------------------------|-----------------------------------------|
  |                ARS                    |           SUT             |            CRM             |                 CRCE                    |
  |------------------------------------------------------------------------------------------------------------------------------------------|


Adaptation:
===========
To adapt this testsuite for a certain (live/model) project the following steps are required:
1. Create a corresponding SUT resource file in the SUTS folder
2. Add a corresponding xxx_supported tag (where xxx is the ${SUT PROJECT TAG PREFIX} defined in the corresponding SUT resource file) to each supported TC
3. Adapt the testsuite specific configuration-resource.txt (located in the same folder as this readme.txt) according to the SUT
4. Create a bulk execution script folder bulk_execution_script/${SUT PROJECT TAG PREFIX} with 2 files according to 
     bulk_execution_script/TNZ/sut-specific.args        (references the SUT resource file of step 1)
     bulk_execution_script/TNZ/run-end2end-tests.sh     


