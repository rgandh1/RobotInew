rem #!/bin/bash

del /F logs\*.*
set BASE=./
set LOGS=--log logs\log.html --report logs\report.html --output logs\output.xml

call pybot --escape star:STAR %LOGS% 001_login.txt
