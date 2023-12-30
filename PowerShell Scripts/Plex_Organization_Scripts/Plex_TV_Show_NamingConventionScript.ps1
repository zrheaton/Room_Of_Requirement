# Ask for user input
$directoryPath = Read-Host -Prompt 'Hit me with the directory path'
$seasonNumber = Read-Host -Prompt 'What season is in this directory'

# Format season number to "Sxx" format
$seasonFormatted = "S{0:D2}" -f [int]$seasonNumber

# Dry run flag
$dryRun = $true

# Function to create new file name
function Get-NewFileName($originalName, $seasonFormatted) {
    if ($originalName -match '(\d+)') {
        $episodeNumber = "E{0:D2}" -f [int]$matches[1]
        $newName = $originalName -replace '(\d+)', "$seasonFormatted$episodeNumber"
        return $newName
    }
    return $null
}

# Renaming process
function Rename-Files($dryRun) {
    Get-ChildItem -Path $directoryPath -File | ForEach-Object {
        $newName = Get-NewFileName $_.Name $seasonFormatted
        if ($null -ne $newName) {
            $newFullPath = Join-Path -Path $directoryPath -ChildPath $newName

            if ($dryRun) {
                Write-Host "Would rename $($_.FullName) to $newFullPath"
            } else {
                Rename-Item -Path $_.FullName -NewName $newName
                Write-Host "Renamed $($_.FullName) to $newFullPath"
            }
        }
    }
}

# Initial dry run
Rename-Files -dryRun $true

# Prompt to apply changes
$applyChanges = Read-Host -Prompt 'Apply changes? (yes/no)'
if ($applyChanges -eq 'yes') {
    Rename-Files -dryRun $false
}
