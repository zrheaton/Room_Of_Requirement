# Ask the user for the file path
$filePath = Read-Host "Hit me with the file path"

# Check if the provided path is valid
if (Test-Path $filePath -PathType Container) {
    # Get all files in the specified directory
    $files = Get-ChildItem -Path $filePath -File

    # Loop through each file to create directories and move files
    foreach ($file in $files) {
        # Construct the directory path
        $dirPath = Join-Path $filePath $file.BaseName

        # Check if the directory already exists
        if (-not (Test-Path $dirPath)) {
            # Create the directory
            New-Item -Path $dirPath -ItemType Directory
        }

        # Construct the new file path
        $newFilePath = Join-Path $dirPath $file.Name

        # Move the file to the new directory
        try {
            Move-Item $file.FullName $newFilePath -Force
        } catch {
            Write-Host "Failed to move file: $($file.Name) to $newFilePath. Error: $_"
        }
    }
} else {
    Write-Host "Invalid file path: $filePath"
}
