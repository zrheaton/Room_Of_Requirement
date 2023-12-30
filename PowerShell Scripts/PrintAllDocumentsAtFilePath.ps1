# Path to the main directory
$mainDirectoryPath = "C:\Users\17206\Desktop\FinalHOAPrintStructure\8 Misc"


function PrintPDFsRecursively {
    param(
        [Parameter(Mandatory=$true)]
        [string]$directoryPath
    )

    $totalPDFs = (Get-ChildItem -Path $directoryPath -Recurse -Filter *.pdf).Count

    $printedPDFs = 0

    Get-ChildItem -Path $directoryPath -Recurse -Filter *.pdf | Sort-Object | ForEach-Object {
        $printedPDFs++
        
        $progress = [math]::Round(($printedPDFs / $totalPDFs) * 100, 2)
        Write-Progress -Activity "Printing PDFs" -Status "Progress: $progress%" -PercentComplete $progress

        Start-Process "chrome.exe" -ArgumentList $_.FullName

        # Wait for the window to appear
        Start-Sleep -Seconds 5

        [System.Windows.Forms.SendKeys]::SendWait("^p")

        Start-Sleep -Seconds 2

        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

        Start-Sleep -Seconds 10
    }

    Write-Output "Printing completed. Printed $printedPDFs of $totalPDFs documents."
}

PrintPDFsRecursively -directoryPath $mainDirectoryPath