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
echo Installing plugin
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin active-directory --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin extended-choice-parameter  --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin extensible-choice-parameter   --username %uid% --password %pwd% 

%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin global-variable-string-parameter --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin greenballs --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin hidden-parameter --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin powershell --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin slack --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin ssh-slaves --username %uid% --password %pwd% 
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 install-plugin uno-choice --username %uid% --password %pwd% 


echo Restarting Jenkins
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 restart --username %uid% --password %pwd% 
