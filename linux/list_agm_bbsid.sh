printf "AGM Name/IP :"; read app
printf "Username :"; read user
printf "Password:"; read -s pass

export token=$(curl -XPOST --user ${user}:${pass} --tlsv1.2 -sSk https://${app}/actifio/session | awk -F'"' '{if ($2 ~ /session_id/) print $4}')
curl -XGET -sSk --tlsv1.2 -H "Authorization: Actifio $token" https://${app}/actifio/config/systeminfo | awk -F'"' '{if ($2 ~ /adhdnode/) { hex=sprintf("%x",$4); hex=substr(hex,length(hex)-4); hex="0x"hex; printf("\n%d\n",hex); }}'
