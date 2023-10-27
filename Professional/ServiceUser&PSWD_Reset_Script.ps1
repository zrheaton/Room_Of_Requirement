#If you put a service name or something similar to it where it says insert you will be able to pull them all and reset the username and password. 

gwmi win32_service -filter 'DisplayName LIKE "<insert_service_display_name%>"' | % { $_.Change($null, $null, $null, $null, $null, $null, 'DOMAIN\username', 'password') }

#This below command will add a service restart to the script if you don't feel like clicking 3 times. 
#Restart-Service scsm