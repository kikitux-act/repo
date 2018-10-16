set uid=admin
set pwd=password
set java_exe="C:\Program Files (x86)\Jenkins\jre\bin\java.exe"
set java_jar="C:\Program Files (x86)\Jenkins\war\WEB-INF\jenkins-cli.jar"
set jenkins_ip=localhost

echo .
echo Kick off a job
%java_exe% -jar %java_jar% -s http://%jenkins_ip%:8080 build 'NPR' --username %uid% --password %pwd% 
