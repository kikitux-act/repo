set uid=admin
set pwd=password
set java_exe="C:\Program Files (x86)\Jenkins\jre\bin\java.exe"
set java_jar="C:\Program Files (x86)\Jenkins\war\WEB-INF\jenkins-cli.jar"
set jenkins_ip=localhost

:: Enable Alow anonymous read access in Configure Global Security
::
@echo off
echo List of jobs in Jenkins
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 list-jobs --username %uid% --password %pwd% 

echo.
echo List of plugins installed in Jenkins
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 list-plugins --username %uid% --password %pwd% 

echo .
echo Deleting existing job
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 delete-job "OnDemand-DB" --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 delete-job "Refresh-Workflow-DB" --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 delete-job "Cleanup-DB" --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 delete-job "AGM-ListHost" --username %uid% --password %pwd% 

echo .
echo Import jobs
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 create-job "OnDemand-DB" --username %uid% --password %pwd% < OnDemand-DB.xml
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 create-job "Refresh-Workflow-DB" --username %uid% --password %pwd% < Refresh-Workflow-DB.xml
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 create-job "Cleanup-DB" --username %uid% --password %pwd% < Cleanup-DB.xml
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 create-job "AGM-ListHost" --username %uid% --password %pwd% < List-Host-REST.xml

echo .
echo Copying supporting scripts to c:\scripts
if not exist "c:\scripts" md "c:\scripts"
copy .\list_dbappname.ps1 c:\scripts
copy .\list_workflows.ps1 c:\scripts
copy .\list_mnttgthost.ps1 c:\scripts
copy .\list_mnttgtapp.ps1 c:\scripts
copy .\list_dbtype.ps1 c:\scripts

echo Restarting Jenkins
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 restart --username %uid% --password %pwd% 
