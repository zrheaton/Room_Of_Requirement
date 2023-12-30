$sourceDirectoryPath = "C:\Users\zrhea\Desktop\IphonePhotos"
$destinationDirectoryPath = "C:\Users\zrhea\Desktop\OrganizedSample" 

Get-ChildItem -Path $sourceDirectoryPath | ForEach-Object {
    $modifiedTime = $_.LastWriteTime
    $baseName = $modifiedTime.ToString("ddMMMyyyy_HHmm")
    $extension = $_.Extension
    $suffix = 64 # ASCII code for 'A' - 1

    do {
        $suffix++
        $formattedDate = $baseName + [char]$suffix + $extension
        $newFullPath = Join-Path $destinationDirectoryPath $formattedDate
    } while (Test-Path $newFullPath)

    Rename-Item $_.FullName -NewName $formattedDate
    Move-Item (Join-Path $sourceDirectoryPath $formattedDate) -Destination $destinationDirectoryPath
    Write-Host "Moved and renamed $($_.Name) to $destinationDirectoryPath\$formattedDate"
}
