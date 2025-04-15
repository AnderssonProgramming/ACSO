# Script to count lines in the hosts file

# Clear the screen
Clear-Host

# Get file path for Windows hosts file
$filePath = "C:\Windows\System32\drivers\etc\hosts"

# Count the lines and print the result
$lineCount = (Get-Content -Path $filePath).Count
Write-Host "El número de líneas del archivo $filePath es: $lineCount"
