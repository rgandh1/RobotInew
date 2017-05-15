This is a generalized CallsGenerator "workspace" containing ALL test cases referenced by the robot framework test suites.
"Generalized" means in this respect that other than normal CallsGenerator workspaces this generalized one is NOT project/testbed specific.
Thus ...
- ... besides the general testcases (supported by all projects/testbeds) it contains also testcases that are specific to a reduced amount (or even only one specific) project(s)/testbed(s)
- ... there is no workspace.ini file contained, since this project specific file has to be created dynamically (or at least maintained) by the robot testsuites (depending on the SUT passed to to suite via CmdLn)
- ... there is no subscribers folder contained, since the hosted files ar are to testsuite and project specific too, so that a centralized maintenance won't bring significant benefit.
  Instead, subscriber have to be individually maintained (dynamically created) by the robot testsuites too.

To avoid messing up this folder with zombie TCs and redundances and to ensure reusability of the TCs (sharability between different authors) some binding rules have to be agreed:

Each TC MUST ...
1. ... explicitely contain its own Adaptation and Valdation rules so that it can be executed with "TC controlled A&V" (switched ON in the workspace options) 
   instead of beeing dependant from a predefined workspace.ini with a proper set of global A&V rules 
2. ... contain a changelog.txt that gives a description of the TC and shows the history of potential changes within the timeline.
3. ... contain a sample-fleXml.csv that provides sample data to demonstrate a successful TC execution
4. ... NOT use fleXml column names (parameter names) that are NOT defined (documented) in ./flexml-parameter-naming-rules.txt

