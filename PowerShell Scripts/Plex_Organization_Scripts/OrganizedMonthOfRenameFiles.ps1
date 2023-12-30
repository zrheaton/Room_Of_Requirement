$baseSourceDirectoryPath = "C:\Users\zrhea\Desktop\YearsOrganizedTest\Test1" # Base directory containing the year folders

# Regex pattern to match the month in the filename
$monthPattern = "\d{2}([a-zA-Z]{3})\d{4}_\d{4}[A-Z]?"

# Array of month abbreviations for folder naming
$monthNames = @("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

Get-ChildItem -Path $baseSourceDirectoryPath -Directory | ForEach-Object {
    $yearFolderPath = $_.FullName

    Get-ChildItem -Path $yearFolderPath | ForEach-Object {
        if ($_.Name -match $monthPattern) {
            $monthAbbrev = $Matches[1]
            if ($monthAbbrev -in $monthNames) {
                $monthFolderPath = Join-Path $yearFolderPath $monthAbbrev

                # Create month folder if it doesn't exist
                if (-not (Test-Path $monthFolderPath)) {
                    New-Item -ItemType Directory -Path $monthFolderPath
                }

                # Move file to the corresponding month folder
                $destinationPath = Join-Path $monthFolderPath $_.Name
                Move-Item $_.FullName -Destination $destinationPath
                Write-Host "Moved $($_.Name) to $monthFolderPath"
            } else {
                Write-Warning "Month abbreviation not recognized: $monthAbbrev in file $($_.Name)"
            }
        } else {
            Write-Warning "Filename format not matched: $($_.Name)"
        }
    }
}
