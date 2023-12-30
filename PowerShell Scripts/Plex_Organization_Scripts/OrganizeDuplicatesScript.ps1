#This script will go through two directories, compare them, and look for duplicates. It will then move the duplicates to a third folder. It is great for organizing servers with plenty of files. 


$dir1 = "<insert comparison folder 1 path>"
$dir2 = "<insert comparison folder 2 path>"
$destination = "<insert location for duplicates"

#Get all files and directories in $dir1
$files1 = Get-ChildItem -Path $dir1 -Recurse

#Get all files and directories in $dir2
$files2 = Get-ChildItem -Path $dir2 -Recurse

#Compare files and directories in $dir1 and $dir2
$duplicates = Compare-Object -ReferenceObject $files1 -DifferenceObject $files2 -IncludeEqual

$movedItems = @()

#Move duplicates from $dir1 to $destination
foreach ($duplicate in $duplicates) {
    if($duplicate.SideIndicator -eq "==") {
        $src = $duplicate.InputObject.FullName
        $dest = $destination + $duplicate.InputObject.FullName.Substring($dir1.Length)
        if($duplicate.InputObject.PSIsContainer) {
            #this is a directory
            if(-not (Test-Path -Path $dest)) {
                #create directory if it doesn't exist in destination
                New-Item -ItemType Directory -Path $dest
            }
        }
        else {
            #this is a file
            #move file to destination
            Move-Item -Path $src -Destination $dest
        }
        $movedItems += $src
    }
}

#Remove original files from $dir1
foreach ($item in $movedItems) {
    Remove-Item -Path $item -Force -Recurse
}

# display message
"Moved and removed the following items:"
$movedItems