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
echo Import jobs
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 create-job "OnDemand-DB" --username %uid% --password %pwd% < OnDemand-DB.xml
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 create-job "Refresh-Workflow-DB" --username %uid% --password %pwd% < Refresh-Workflow-DB.xml
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 create-job "Cleanup-DB" --username %uid% --password %pwd% < Cleanup-DB.xml


echo Restarting Jenkins
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 restart --username %uid% --password %pwd% 
