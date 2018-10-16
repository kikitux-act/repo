$Path = "C:\Program Files (x86)\PuTTY\putty.exe"
$Prm1 = "-v"
$Prm2 = "-ssh"
$Prm3 = "-t"
$Prm4 = "jenkin01@10.61.5.187"
$Prm5 = "-P"
$Prm6 = "22"
$Prm7 = "-i"
$Prm8 = "C:\Users\Administrator\Desktop\id_rsa.ppk"
$Prm9 = "-m"
$Prm10 = "C:\Users\Administrator\Desktop\cmd.txt"

&$Path $Prm1 $Prm2 $Prm3 $Prm4 $Prm5 $Prm6 $Prm7 $Prm8 $Prm9 $Prm10
