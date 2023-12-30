$directory = "C:\Users\17206\Desktop\HashesScript"
$files = Get-ChildItem -Path $directory -File
$fileHashes = @()
foreach ($file in $files) {
    $hash = Get-FileHash -Path $file.FullName | Select-Object -ExpandProperty Hash
    $fileHashes += [PSCustomObject]@{
        FileName = $file.Name
        Hash     = $hash
    }
}
$output = ($fileHashes | ForEach-Object { $_.FileName + " - " + $_.Hash }) -join "`r`n"
$outputFile = "C:\Users\17206\Desktop\HashesScript\Output.txt"
$output | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "File hashes have been calculated and saved to '$outputFile'."



# Specify the directory path
$directory = "C:\Users\17206\Desktop\Picus\PCAPSAVES"
$files = Get-ChildItem -Path $directory -File

# Create an array to store the file hashes
$fileHashes = @()

# Loop through each file and calculate the hash
foreach ($file in $files) {
    $hash = Get-FileHash -Path $file.FullName | Select-Object -ExpandProperty Hash
    $fileHashes += [PSCustomObject]@{
        FileName = $file.Name
        Hash     = $hash
    }
}

# Create a string to store the formatted output
$output = ($fileHashes | ForEach-Object { $_.FileName + " - " + $_.Hash }) -join "`r`n"

# Specify the output file path
$outputFile = "C:\Users\17206\Desktop\HashesScript\Output.txt"

# Write the output to the file
$output | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "File hashes have been calculated and saved to '$outputFile'."
