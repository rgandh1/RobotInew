======================================================================================
Notes for executing the Administrative Testcases for CRM
======================================================================================

Here you can find all the important information if you want to execute the Administrative Testcases for CRM
The Testcases given refer on the Testcases provided by Thomas Glaser on Spira Team (VM Columbia) 
current state: 03/07/2013

=======================================================================================

Prerequisites:
No User should exist with the same username given in the variables
Login Data should be declared in the variables
Robotframework has to be installed including following external libraries:
* Selenium2Library
* DatabaseLibrary

CRM (including Database) Running
Standard CRM Roles installed:
* CRM Manager
* Customercare
* Customercare Limited
* Shop Agent

======================================================================================

Before you execute the Testcases, you have to update the variables:
${SERVER}             IP-Adress where CRM is running
${BROWSER}            The Webbrowser used for interface testing (firefox)
${DELAY}              The Delay between each teststep (if its to fast there might be some problems) 
${LOGIN URL}          Excact URL of the CRM
${CRMMANAGER}         Username of the CRM Manager User
${CRMMANAGERPASSWD}   Password of the CRM Manager USer
${NEW USERNAME}       Username for the new User we create
${NEW ROLENAME}       Rolename for the new Role we create
${NEW TESTSHOP}       Shopname for the new Shop we create
${NEW TESTAGENT}      Shop Agent name for the new shop agent we create
${MSISDN}             MSISDN for a valid Subscriber to test if the user can reach him
${CRMDB NAME}         Name of the DB 
${CRMDB USER}         Userlogin for CRM DB
${CRMDB PWD}          Password of the CRM DB User
${CRMDB HOST}         IP Address of the CRM DB
${CRMDB PORT}         Port of the CRM DB
${CRMDB ROLE}         Table within the DB where Users can be found
${CRMDB SHOP}         Table within the DB where Shops can be found

====================================================================================

Testcases have to be executed in the right order, as some of them depend on the previous:
* 001 - Create Role before 003 - Assign User to Role
* 007 - Shops before 008 - Shop Agents
* Cleanup as a Final step to reset the Testenvironment to the first state

===================================================================================

Important Notes:

The information which is needed for other teststeps is provided as variables
Dont change the information within the Create new Shop Keyword as the Zipcode and City is needed in another Teststep
If you leave the Workstation while running the test, ensure that the Screensaver will not get activated (Selenium will have some problems)

===================================================================================
XPath:
    Click Element    //tr[td[text()='${NEW ROLENAME}']]/td[input[@value='Delete']]

To ensure that only the Role which was created before named "NEW ROLENAME" will be deleted.
(click the input button with value Delete within the tr where the text within one td = the new role name)





