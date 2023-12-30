#This script will move files from one directory to another with a flood gate so you can protect diskqueues and such. 

# Directory path for the source
$Source = "<insert source path>"

# Directory path for the destination
$Destination = "<insert destination path>"

# Number of files to move from source to dest at a time.
# Values: Int, default is 5 
$FileLimit = 100

# Number of seconds to sleep before looking to see if the dest directory is empty.
# Values: Int, default is 60
$SleepTime = 60
#######################################

$Now = Get-Date
$originationInfo = Get-ChildItem $Source | Measure-Object
Write-Host $Now, "Files in HOLD:", $originationInfo.count -foregroundcolor "red" #Returns the count of all of the files in the directory

while ('$originationInfo.count -gt 0')
{

$Now = Get-Date
$destinationInfo = Get-ChildItem $Destination | Measure-Object
Write-Host $Now, "Files in process:" $destinationInfo.count -foregroundcolor "yellow" #Returns the count of all of the files in the directory
If ($destinationInfo.count -lt $FileLimit) 
  {    
    $DestCount = Get-ChildItem $Source | Measure-Object
    if ($DestCount.count -lt 20)
	{
		Write-Host "***File Move Complete***" -foregroundcolor "white"
		exit
	}
	 
	Write-Host $Now, "Moving" $FileLimit "for processing." -foregroundcolor "green"
        
	#Destination for files 
	$PickupDirectory = Get-ChildItem -Path $Source         
	             
        $Counter = 0 
        foreach ($file in $PickupDirectory) {     
        if ($Counter -ne $FileLimit)     
        {        	    
            Write-Host $file.FullName -foregroundcolor "green" #Output file fullname to screen      	          
            Move-Item $file.FullName -destination $Destination         
            $Counter++	    
            }   
        } 
	$originationInfo = Get-ChildItem $Source | Measure-Object
	Write-Host $Now, "Files in HOLD:", $originationInfo.count -foregroundcolor "red"
  }
     Start-Sleep -s $SleepTime 
}
Exit