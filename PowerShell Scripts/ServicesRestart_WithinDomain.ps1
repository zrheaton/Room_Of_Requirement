gwmi win32_service -filter 'DisplayName LIKE "<insert_service_name_string>%"' | % { $_.Change($null, $null, $null, $null, $null, $null, 'DOMAIN\username', 'password') }

#This below command will add a service restart to the script if you don't feel like clicking 3 times. 
#Restart-Service scsm