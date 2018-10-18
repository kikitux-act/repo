#/bin/bash
#set -x
#set -o nounset
#set -o errexit

#IFS for jobs with spaces.
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")


readonly numparms=1

usage () 
{
  echo -e "\n  usage: $0 hostname \nexample: $0 melljenkins \n\n Name of the Jenkins server \n" >&2; exit 1;
}

[ $# -ne $numparms ] && usage 

case $1 in
  "melljenkins") ip_addr="10.65.5.199"  ; token="37990b6d70627f7a3ef4f34cd993a048"   ; uid="michael.chew" ;;
  "melwjenkins") ip_addr="10.65.5.198"  ; token="6e9f2efd59a3f11d41607fc16424817f"   ; uid="michael.chew" ;;
  "demomgmt2")   ip_addr="172.24.2.170" ; token="11b87f4f469975baf8d66e36f5fc6e64c9" ; uid="admin" ;;
  "localhost")   ip_addr="127.0.0.1"    ; token="11f80a3f406fe289401d3d735ce7419c11" ; uid="michael" ;;
   *) echo -e "Invalid Jenkins server !!\nList of Jenkins server: melljenkins , melwjenkins , demomgmt2 , localhost " ; exit 1 ;;
esac

[ ! -f ./jenkins-cli.jar ] && curl -O http://$uid:$token@$ip_addr:8080/jnlpJars/jenkins-cli.jar 

echo -e "\nList of Jenkins jobs: \n"
java -jar ./jenkins-cli.jar -s http://$uid:$token@$ip_addr:8080/ list-jobs 

[ ! -d $1 ] && mkdir $1

for i in $( java -jar ./jenkins-cli.jar -s http://$uid:$token@$ip_addr:8080/ list-jobs ) ; do 
  i="$(echo "$i"|tr -d '\r')"
  java -jar ./jenkins-cli.jar -s http://$uid:$token@$ip_addr:8080/ get-job ${i} > $1/${i}.xml
done
IFS=$SAVEIFS

tar cvfj "$1-jenkins-jobs.tar.bz2" $1/*.xml

rm ./jenkins-cli.jar
