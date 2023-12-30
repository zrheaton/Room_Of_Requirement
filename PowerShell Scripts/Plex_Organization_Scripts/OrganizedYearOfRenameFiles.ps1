$sourceDirectoryPath = "C:\Users\zrhea\Desktop\IphoneTesFolder"
$baseDestinationPath = "C:\Users\zrhea\Desktop\YearsOrganizedTest" 

# Regex pattern to match the year in the filename
$yearPattern = "\d{2}([a-zA-Z]{3})(\d{4})_\d{4}[A-Z]?"

Get-ChildItem -Path $sourceDirectoryPath | ForEach-Object {
    if ($_.Name -match $yearPattern) {
        $year = $Matches[2] # Capture the year from the filename
        $yearFolderPath = Join-Path $baseDestinationPath $year

        # Create year folder if it doesn't exist
        if (-not (Test-Path $yearFolderPath)) {
            New-Item -ItemType Directory -Path $yearFolderPath
        }

        # Move file to the corresponding year folder
        $destinationPath = Join-Path $yearFolderPath $_.Name
        Move-Item $_.FullName -Destination $destinationPath
        Write-Host "Moved $($_.Name) to $yearFolderPath"
    } else {
        Write-Warning "Filename format not matched: $($_.Name)"
    }
}
